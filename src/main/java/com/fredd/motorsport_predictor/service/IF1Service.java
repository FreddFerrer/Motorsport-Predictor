package com.fredd.motorsport_predictor.service;

import com.fredd.motorsport_predictor.rest.f1.drivers.F1DriversDto;
import com.fredd.motorsport_predictor.rest.f1.tracks.F1TracksDto;

public interface IF1Service {
    F1DriversDto getDriversByYear(int year);
    F1TracksDto getCurrentSchedule();
}
