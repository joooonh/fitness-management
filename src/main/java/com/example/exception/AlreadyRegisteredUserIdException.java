package com.example.exception;

public class AlreadyRegisteredUserIdException extends ApplicationException {

	private static final long serialVersionUID = -2558635518697325975L;

	public AlreadyRegisteredUserIdException(String message) {
		super(message);
	}
}
