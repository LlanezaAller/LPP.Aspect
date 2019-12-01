package miw.aspectj;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.stream.Collectors;

public aspect AspectTimer {
	
	// Para evitar que si existe un acierto en caché no se ejecute el aspecto del profiler se incluye preferencia
	declare precedence: ObserverAspect, ObserverProtocol, AspectTimer, AspectCache;
	
	static HashMap<Integer, ArrayList<Long>> fibonacci = new HashMap<Integer, ArrayList<Long>>();

	int around(int num): call(int  *.fibonacci(int)) && args(num) && within(Test){
		// Cálculo de tiempos
		long t1 = System.nanoTime();
		int value = proceed(num);
		long t2 = System.nanoTime();
		System.out.println("[TIMER] \t\t\tTiempo: " + (t2-t1) + " nanosegundos");
		
		// En caso de que sea la primera instancia de ese número se crea la lista para trackear sus tiempos
		if(!fibonacci.containsKey(num)) {
			fibonacci.put(num, new ArrayList<Long>());
		}
		// Se incluye en la lista te tiempos el del valor a calcular
		fibonacci.get(num).add(t2-t1);
		return value;
	}
	
	
	pointcut afterMain(): execution(static void Test.main(..));
	
	after(): afterMain(){
		// Listado final de tiempos
		System.out.println("*****************");
		System.out.println("Tiempos totales:");
		fibonacci.forEach( (key, value) -> {
			System.out.println("Para el valor ["+key+"] el tiempo es: "+ 
					value.stream()
			           .map(Object::toString)
			           .collect(Collectors.joining(", ")));
		});
	}
	
	
}
