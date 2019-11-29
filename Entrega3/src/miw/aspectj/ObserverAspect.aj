package miw.aspectj;

public aspect ObserverAspect extends ObserverProtocol {

	//	Roles played by the MeteorologicalStation and the WeatherMan
	declare parents: Calculator implements Subject;
	declare parents: CalculatorUseOnScreen implements Observer;

	private int Calculator.calls = 0;

	/**
	 * Pointcut that catches any call to MeteorologicalStation.observ()
	 */
	protected pointcut declareObserver(Calculator s, CalculatorUseOnScreen o):
		call(void CalculatorUseOnScreen.observ(*)) && args(s) && target(o);

	/**
	 * Advice that adds a new (autodeclared) observer
	 */
	after(Calculator s, CalculatorUseOnScreen o) : declareObserver(s, o) {
		addObserver((Subject)s, (Observer)o); }	

	/**
	 * Pointcut that catches any call to MeteorologicalStation.set*()
	*/
	protected pointcut subjectChange(Subject subject):
		call(void Calculator.fibonacci(*)) && target(subject);

	after(): subjectChange(subject){
		
	}

	/**
	* This method defines how observers are updated when a change in
	* the subject occurs. It is a concret implementation of the corresponding
	* method in the superaspect.
	*/
	protected void updateObserver(Subject subject, Observer observer) {
		Calculator em = (Calculator) subject;
		CalculatorUseOnScreen hdt = (CalculatorUseOnScreen) observer;
		hdt.inform(calculatorTimes++);
	}
}
