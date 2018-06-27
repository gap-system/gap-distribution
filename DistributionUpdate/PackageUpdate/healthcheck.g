# Loading all packages

pkgnames := SortedList(RecNames(GAPInfo.PackagesInfo));
unloads := Filtered( pkgnames, n -> LoadPackage(n)=fail);

Print("******************************************************************\n\n");
Print("*** This GAP installation contains ", Length(pkgnames), " packages\n\n");

Print("*** ", Length(unloads), " packages not loadable in this installation:\n");
for name in unloads do
  Print("- ", name, "\n");
od;

# Release dates

dates := [];
releases := [];

for name in pkgnames do
  r := PackageInfo( name )[1];
  Add( dates, List( SplitString( r.Date, "/" ), Int ) ); 
  Add( releases, [ r.Date, r.PackageName, r.Version ] );
od;
Print("\n");

SortParallel( dates, releases, 
    function(d1,d2) 
    return d1[3] < d2[3] or 
           ( d1[3]=d2[3] and d1[2]<d2[2] ) or 
           ( d1[3]=d2[3] and d1[2]=d2[2] and d1[1]<d2[1] ) ; 
    end );

Print("*** Releases in chronological order:\n");
for r in releases do
  Print( r[1], " : ", r[2], " ", r[3], "\n" );
od;
Print("\n");

Print("*** Number of packages last updated in specified year:\n");
for x in  Collected(List(dates,x->x[3])) do
  Print(x[1], " : ", x[2], "\n");
od;
Print("\n");

# Test files

havetests := Filtered( pkgnames, n -> IsBound( GAPInfo.PackagesInfo.(n)[1].TestFile));
lacktests := Filtered( pkgnames, n -> not IsBound( GAPInfo.PackagesInfo.(n)[1].TestFile));

Print("*** ", Length(havetests), " packages have standard test in PackageInfo.g\n");
Print("*** ", Length(lacktests), " packages have no standard test in PackageInfo.g\n\n");

Print("For packages with tests, use the list below for Travis CI tests:\n");
for name in havetests do
  Print("- PKG_NAME=",name,"\n");
od;
Print("\n");

Print("For packages without tests, this is the TODO list to add them:\n");
for name in lacktests do
  Print("- [ ] ", name,"\n");
od;
Print("\n");

# GAPDoc manuals
nogapdoc := [ ];
nocss    := [ ];

for name in pkgnames do  
  d := PackageInfo( name )[1].PackageDoc;
  for book in d do
    if EndsWith(book.HTMLStart, "/chapters.htm") then
      Add (nogapdoc, name);
    elif Filename(DirectoriesPackageLibrary( name,"" ),"doc/manual.css") = fail then
      Add (nocss, name);
    fi;
  od;  
od;

Print("*** ", Length(pkgnames)-Length(nogapdoc), 
  " packages use GAPDoc (immediately or via AutoDoc) \n\n");
Print("*** ", Length(nogapdoc), " packages do not have GAPDoc-based documentation:\n");
for name in nogapdoc do
  Print("- [ ] ", name, "\n");
od;
Print("\n");

Print("*** ", Length(nocss), " GAPDoc-based manuals miss ccs files:\n");
for name in nocss do
  Print("- [ ] ", name, "\n");
od;
Print("\n\n");

# Package authors
authors:=List(pkgnames,n->GAPInfo.PackagesInfo.(n)[1].Persons);
authors:=List(authors, a -> List(a, x -> [ x.LastName, x.FirstNames ] ) );
authors:=Concatenation(authors);
authors:=Set(authors);
names:=List(authors, x -> Concatenation( x[2], " ", x[1], ", \<\>" ) );
out:="";
for n in names do
  Append(out, n );
od;
Print("*** Around ", Length(authors), " package authors/maintainers involved\n");
Print("(this is an estimate, and the list may contain duplicates):\n\n");
Print(out);
Print("\n\n");

# Now check for those with same surname and different first names whether 
# they are same persons with different spelling, or different persons.

Print("Authors with the same surname and different first names:\n");
surnames:=Set(List(authors,x -> x[1]));
d:=Filtered(surnames, s -> Number( authors, a -> a[1]=s ) > 1 );
for s in d do
  names := Filtered(authors, a -> a[1]=s);
  names := Concatenation(List(names, x -> Concatenation( x[2], " ", x[1], ", \<\>" ) ) );
  Print(" - ", names,"\n");
od;
Print("\n\n");
 