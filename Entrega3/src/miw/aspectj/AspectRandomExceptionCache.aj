package miw.aspectj;

import java.util.Random;

public aspect AspectRandomExceptionCache {
	
	void around(Integer num, Integer value): call(void  AspectCache.insert(Integer, Integer)) && args(num, value){
		Random random=new Random();
		int aleatorio=random.nextInt(100);
		if(aleatorio < 75){
			throw new NullPointerException();
		}
		proceed(num,value);
	}
}
