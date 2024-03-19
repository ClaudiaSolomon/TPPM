//1
class Queue<T>
{
  List<T> list=[];
  void push(T el)
  {
    list.add(el);
  }
  T pop()
  {
    if(list.isEmpty)
    {
      throw FormatException('Queue is empty');
    }
    return list.removeAt(0);
  }
  T front()
  {
    if(list.isEmpty)
    {
      throw FormatException('Queue is empty');
    }
    return list[0];
    
  }
  T back()
  {
    if(list.isEmpty)
    {
      throw FormatException('Queue is empty');
    }
    return list[list.length-1];
  }
  bool isEmpty(){
    if(list.length==0)
    {
      return true;
    }
    return false;
  }
  String toString()
  {
    return list.toString();
  }

}

//3
class Client{
  final String _name;
  double _purchasesAmount=0;
  Client(String name) : _name = name;
  String getName() {
    return _name;
  }

  double getPurchasesAmount() {
    return _purchasesAmount;
  }
  void addPurchasesAmount(double amount) {
    _purchasesAmount += amount;
  }
}
class LoyalClient extends Client {
  LoyalClient(String name) : super(name);

  double getLoyalPurchasesAmount() {
    return super.getPurchasesAmount();
  }

  void discount() {
    double currentAmount = super.getPurchasesAmount();
    double discountedAmount = currentAmount *0.1;
    super.addPurchasesAmount(-discountedAmount);
  }
}

void main()
{
  print("------------1-----------");
  Queue<int> myQueue = Queue<int>();

  print("empty= ${myQueue.isEmpty()}");
  try{
  myQueue.pop();
  print("pop: ${myQueue.toString()}");
}
  catch(e)
  {
    print("Exception caught: $e");
  }

  myQueue.push(1);
  myQueue.push(2);
  myQueue.push(3);

  print("string:: ${myQueue.toString()}");
  try {
    print("front: ${myQueue.front()}");
  } catch (e) {
    print("Exception caught: $e");
  }
  try {
    print("back: ${myQueue.back()}");
  } catch (e) {
    print("Exception caught: $e");
  }

  print("------------3-----------");
  Client regularClient = Client("Maria");
  regularClient.addPurchasesAmount(10);
  print("${regularClient.getName()}'s total purchases amount: ${regularClient.getPurchasesAmount()}");

  LoyalClient loyalClient = LoyalClient("Ana");
  loyalClient.addPurchasesAmount(25);
  print("${loyalClient.getName()}'s total purchases amount: ${loyalClient.getLoyalPurchasesAmount()}");

  loyalClient.discount();
  print("${loyalClient.getName()}'s total purchases amount after discount: ${loyalClient.getLoyalPurchasesAmount()}");

}