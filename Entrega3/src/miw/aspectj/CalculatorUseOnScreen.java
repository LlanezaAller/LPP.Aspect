package miw.aspectj;

public class CalculatorUseOnScreen {
	
	private String name;
	
	public CalculatorUseOnScreen(String n) {
		name=n;
	}


	public void observ(Calculator em){
		System.out.println(name+": Soy un observador");
	}
	
	public void inform(int times){
		System.out.println("\t\t\t\t\t\t[Inform] Calculator ha usado fibonacci " + times + " veces");
	}
}
