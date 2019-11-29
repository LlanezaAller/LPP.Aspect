package miw.aspectj;

public aspect AspectTimer {

	int around(int num): call(int  *.fibonacci(int)) && args(num) && within(Test){
		long t1 = System.nanoTime();
		int value = proceed(num);
		long t2 = System.nanoTime();
		System.out.println("Tiempo: " + (t2-t1) + " nanosegundos");
		return value;
	}
}
