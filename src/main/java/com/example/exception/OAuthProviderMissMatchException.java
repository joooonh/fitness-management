package com.example.exception;

public class OAuthProviderMissMatchException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	public OAuthProviderMissMatchException(String message) {
		super(message);
	}
}
