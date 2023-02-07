package com.example.exception;

public class AlreadyRegisteredEmailException extends ApplicationException{

	private static final long serialVersionUID = 5009010903146055204L;

	public AlreadyRegisteredEmailException(String message) {
		super(message);
	}
}
