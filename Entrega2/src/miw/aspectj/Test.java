package miw.aspectj;

import java.util.Random;

public class Test {

	public static void main(String[] args) {
		Calculator calculator=new Calculator();
		Random random=new Random();
		int aleatorio;
		
		for (int i=0;i<20;i++) {
			aleatorio=random.nextInt(10);
			System.out.println("Se procede a calcular fibonacci de " + aleatorio);
			System.out.println("["+i+" iteration] Fibonacci number in position ["+aleatorio+"] is ["+calculator.fibonacci(aleatorio)+"]\n");
		}
	}
}
