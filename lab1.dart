

void prime_numbers() {
  var contor=0;
  var numar=2;
  var ok;
while(contor<100){
  ok=1;
  for(int i=2;i<numar/2;++i){
    if(numar%i==0)
    {
      ok=0;
      break;
    }
  }
  if(ok==1){
    contor++;
    print(numar);
  }
  numar++;
}
}

void phrase(String s){
  String cuvant="";
  for(int i=0;i<s.length;i++){
    if(i<s.length){
    while(s[i].compareTo(" ")!=0&&i<s.length)
    {
      cuvant+=s[i];
      i++;
      if(s[i]==" "){
        break;
      }
    }
    }
    if(cuvant.compareTo("")==1){ 
      print(cuvant);
      cuvant="";
    }
    if(i<s.length){
    while(s[i].compareTo(" ")==0&&i<s.length)
    {
      i++;
      if(i==s.length){
        break;
      }
    }
    i--;
    }

  }

}
void numbers(String text){
  int sum=0;
  int nr=0;
  for(int i=0;i<text.length;i++){
    if(int.tryParse(text[i]) != null){
      nr=nr*10+int.parse(text[i]);
    }
    else{
      sum+=nr;
      nr=0;
    }
  }
  print(sum);

}

void convert(String cuv){
  String new_string="";
  for(int i=0;i<cuv.length;i++){
    if(cuv[i]==cuv[i].toUpperCase()){
      if(i!=0){
      new_string+="_";
      new_string+=cuv[i].toLowerCase();
      }
      else{
        new_string+=cuv[i].toLowerCase();
      }

    }
    else{
      new_string+=cuv[i];
    }
  }
  print(new_string);
}

void main(){
  print("\n#1\n");
  prime_numbers();
  print("\n#2\n");
  phrase("Ana are   mere  ");
  print("\n#3\n");
  numbers("a23bv 9 ");
  print("\n#4\n");
  convert("AnaAreMere");
}