package miw.aspectj;

import java.util.*;

public abstract aspect ObserverProtocol  {
	
	protected interface Subject {}
	protected interface Observer {}
	
	private HashMap<Subject, List<Observer>> listObservers;

	/**
	* Returns the observers for a particular object.
	* This method is used internally (not public).
	*/
	protected List<Observer> getObservers(Subject s) {
		if (listObservers == null)
			listObservers=new HashMap<Subject, List<Observer>>();
		List<Observer> observers=listObservers.get(s);
		if (observers==null) {
			observers=new LinkedList<Observer>();
			listObservers.put(s, observers);
		}
		return observers;
	}
	
	/**
	* Adds a observer to a subject
	*/
	public void addObserver(Subject subject, Observer observer) {
		getObservers(subject).add(observer);
	}

	/**
	* Deletes a observer from a subject
	*/
	public void removeObserver(Subject subject, Observer observer) {	
		getObservers(subject).remove(observer);
	}
	
	/**
	* Catches any state change in the subject that must be notified
	* to its observers. It will be implemented in a subaspect..
	*/
	protected abstract pointcut subjectChange(Subject s);

	/**
	* This advice notifies the changes to the observers
	*/
	after(Subject subject): subjectChange(subject) {
		Iterator<Observer> iter = getObservers(subject).iterator();
		while (iter.hasNext()) {
			updateObserver(subject, ((Observer)iter.next()));
		}
	}

	/**
	* This method defines how observers are updated when a change in
	* the subject occurs. It will be implemented in a subaspect.
	*/
	protected abstract void updateObserver(Subject subject,Observer observer);
}
