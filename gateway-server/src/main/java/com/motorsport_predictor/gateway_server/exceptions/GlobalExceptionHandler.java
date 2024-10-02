package com.motorsport_predictor.gateway_server.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {
    //controla los errores de los campos
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Object> handlderMethodArgumentNotValidException(MethodArgumentNotValidException exception,
                                                                          WebRequest webRequest) {
        Map<String, String> errorMap = new HashMap<>();
        exception.getBindingResult().getAllErrors().forEach(error -> {
            String field = ((FieldError) error).getField();
            String message = error.getDefaultMessage();
            errorMap.put(field, message);
        });

        CustomErrorResponse errorResponse = new CustomErrorResponse("Error during registration", errorMap);
        errorResponse.setPath(webRequest.getDescription(false));

        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }

    //controla los errores not found 404
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<CustomErrorResponse> handlerResourceNotFoundException(ResourceNotFoundException exception,
                                                                                WebRequest webRequest) {
        CustomErrorResponse apiResponse = new CustomErrorResponse(exception.getMessage(), webRequest.getDescription(false));
        return new ResponseEntity<>(apiResponse, HttpStatus.NOT_FOUND);
    }


    //controla los errores de logica o de los catch en general 400
    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<CustomErrorResponse> handlerBadRequestException(BadRequestException exception,
                                                                          WebRequest webRequest) {
        CustomErrorResponse apiResponse = new CustomErrorResponse(exception.getMessage(), webRequest.getDescription(false));
        return new ResponseEntity<>(apiResponse, HttpStatus.BAD_REQUEST);
    }

    //controla los errores de varios tipos y globalizrlo con un error 404
    @ExceptionHandler(Exception.class)
    public ResponseEntity<CustomErrorResponse> handlerException(Exception exception,
                                                                WebRequest webRequest) {
        CustomErrorResponse apiResponse = new CustomErrorResponse(exception.getMessage(), webRequest.getDescription(false));
        return new ResponseEntity<>(apiResponse, HttpStatus.NOT_FOUND);
    }

    // Controla los errores de acceso denegado
    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<CustomErrorResponse> handlerAccessDeniedException(AccessDeniedException exception, WebRequest webRequest) {
        CustomErrorResponse apiResponse = new CustomErrorResponse("Access denied", webRequest.getDescription(false));
        return new ResponseEntity<>(apiResponse, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(EmailVerificationException.class)
    public ResponseEntity<CustomErrorResponse> handleEmailVerificationException(EmailVerificationException exception,
                                                                                WebRequest webRequest) {
        CustomErrorResponse errorResponse = new CustomErrorResponse(
                exception.getMessage(),
                "User creation failed due to email verification issue.");
        errorResponse.setPath(webRequest.getDescription(false));
        return new ResponseEntity<>(errorResponse, HttpStatus.BAD_REQUEST);
    }
}
