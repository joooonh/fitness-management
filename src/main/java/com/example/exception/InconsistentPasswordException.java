package com.example.exception;

public class InconsistentPasswordException extends ApplicationException{

	private static final long serialVersionUID = -8013262539341485369L;

	public InconsistentPasswordException(String message) {
		super(message);
	}

}
