//1
void largeNumber(List<String> args) {
  var numbers = <int>[];

  if (args.isEmpty) {
    print('no arguments given');
    return;
  }

  for (int i = 0; i < args.length; i++) {
    if (int.tryParse(args[i]) != null) {
      numbers.add(int.parse(args[i]));
    }
  }
  var ok=0;
  int i=numbers.length-1;
  while(numbers[i]==9){
    ok=1;
    numbers[i]=0;
    i--;
    if(i==-1)
    {
      break;
    }
  }
  if(i==-1)
  {
    if(ok==1){
    numbers[0]=1;
    numbers.add(0);
  }
  }
  else{
    numbers[i]++;
  }
  print(numbers);
}

//2
void cuvant(List<String> args)
{
  var map = Map<String,int>();
  if (args.isEmpty) {
    print('no arguments given');
    return;
  }

  for (int i = 0; i < args.length-1; i++) {
    map[args[i]]=int.parse(args[i+1]);
    i++;
  }
  String s=args[args.length-1];
  int suma=0;
  for(int i=0;i<s.length;i++)
  {
    suma+=map[s[i]]??0;
  }
  print(suma);
}

//3
int perechi_bune(List<int> l)
{
  int nr=0;
  var s = Set<int>(); 
  for(int i=0;i<l.length;i++)
  {
    for(int j=i+1;j<l.length;j++)
    {
      if(l[i]==l[j]){
        s.add(l[i]);
        nr++;
      }
    }
  }
  print(s);
  return nr;
}

//4
int grupuri(int n)
{
  int nr=0;
  int m=n;
  int suma=0;
  while(m!=0)
  {
    suma+=m%10;
    m=m~/10;
  }
  List<int> l = List<int>.filled(999, 0,growable: true);
  
  for(int j=0;j<=n;j++)
  {
    suma=0;
    int i=j;
    while(i!=0)
    {
      suma+=i%10;
      i=i~/10;
    }
    if (l.length <= suma) {
      l.length = suma + 1;
    }
    l[suma]++;
  }
  int maxi=0;
  for(int i=0;i<l.length;i++)
  {
    if(l[i]>maxi)
    {
      maxi=l[i];
    }
  }
  for(int i=0;i<l.length;i++)
  {
    if(l[i]==maxi)
    {
      nr++;
    }
  }
  return nr;
}

void main(List<String> args) {
  // print("-----1-----");
  // largeNumber(args);
  // //dart lab2.dart 9 9 9
print("-----2-----");
  cuvant(args);
  //dart lab2.dart A 5 B 3 C 9 ABBCC

print("-----3-----");
  int nr=perechi_bune([1,2,3,4,1,2,6,2,7]);
  print("nr perechi=$nr");

print("-----4-----");
  int nr_1=grupuri(30);
  print("nr grupuri=$nr_1");
}
