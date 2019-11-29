package miw.aspectj;

public class Calculator {
	
	public int fibonacci(int position) {
		System.out.println("\tCalculating fibonacci("+position+") ...");
		if (position==0)
			return 0;
		else
			if (position==1)
				return 1;
			else
				return fibonacci(position-1)+fibonacci(position-2);
	}
}