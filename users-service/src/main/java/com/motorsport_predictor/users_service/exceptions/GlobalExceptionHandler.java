package com.motorsport_predictor.users_service.exceptions;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.NoHandlerFoundException;

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

    //controla los errores globales de los path en 404
    @ExceptionHandler(NoHandlerFoundException.class)
    public ResponseEntity<CustomErrorResponse> handlerNoHandlerFoundException(NoHandlerFoundException exception,
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

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<CustomErrorResponse> handlerDataIntegrityException(DataIntegrityViolationException exception, WebRequest webRequest) {
        CustomErrorResponse apiResponse = new CustomErrorResponse(exception.getMessage(), webRequest.getDescription(false));
        return new ResponseEntity<>(apiResponse, HttpStatus.CONFLICT);
    }
}
