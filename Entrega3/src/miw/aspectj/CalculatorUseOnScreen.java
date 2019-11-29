package miw.aspectj;

public class CalculatorUseOnScreen {
	
	private String name;
	
	public CalculatorUseOnScreen(String n) {
		name=n;
	}


	public void observ(Calculator em){
		System.out.println(name+": I am an observer");
	}
	
	public void inform(int times){
		System.out.println("Calculator use fibonacci " + times + " times");
	}
}
