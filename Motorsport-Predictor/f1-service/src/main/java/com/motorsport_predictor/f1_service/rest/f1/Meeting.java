package com.motorsport_predictor.f1_service.rest.f1;

import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "circuit_key",
        "circuit_short_name",
        "meeting_key",
        "meeting_code",
        "location",
        "country_key",
        "country_code",
        "country_name",
        "meeting_name",
        "meeting_official_name",
        "gmt_offset",
        "date_start",
        "year"
})
@Generated("jsonschema2pojo")
public class Meeting {

    @JsonProperty("circuit_key")
    private Integer circuitKey;
    @JsonProperty("circuit_short_name")
    private String circuitShortName;
    @JsonProperty("meeting_key")
    private Integer meetingKey;
    @JsonProperty("meeting_code")
    private String meetingCode;
    @JsonProperty("location")
    private String location;
    @JsonProperty("country_key")
    private Integer countryKey;
    @JsonProperty("country_code")
    private String countryCode;
    @JsonProperty("country_name")
    private String countryName;
    @JsonProperty("meeting_name")
    private String meetingName;
    @JsonProperty("meeting_official_name")
    private String meetingOfficialName;
    @JsonProperty("gmt_offset")
    private String gmtOffset;
    @JsonProperty("date_start")
    private String dateStart;
    @JsonProperty("year")
    private Integer year;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<>();

    @JsonProperty("circuit_key")
    public Integer getCircuitKey() {
        return circuitKey;
    }

    @JsonProperty("circuit_key")
    public void setCircuitKey(Integer circuitKey) {
        this.circuitKey = circuitKey;
    }

    @JsonProperty("circuit_short_name")
    public String getCircuitShortName() {
        return circuitShortName;
    }

    @JsonProperty("circuit_short_name")
    public void setCircuitShortName(String circuitShortName) {
        this.circuitShortName = circuitShortName;
    }

    @JsonProperty("meeting_key")
    public Integer getMeetingKey() {
        return meetingKey;
    }

    @JsonProperty("meeting_key")
    public void setMeetingKey(Integer meetingKey) {
        this.meetingKey = meetingKey;
    }

    @JsonProperty("meeting_code")
    public String getMeetingCode() {
        return meetingCode;
    }

    @JsonProperty("meeting_code")
    public void setMeetingCode(String meetingCode) {
        this.meetingCode = meetingCode;
    }

    @JsonProperty("location")
    public String getLocation() {
        return location;
    }

    @JsonProperty("location")
    public void setLocation(String location) {
        this.location = location;
    }

    @JsonProperty("country_key")
    public Integer getCountryKey() {
        return countryKey;
    }

    @JsonProperty("country_key")
    public void setCountryKey(Integer countryKey) {
        this.countryKey = countryKey;
    }

    @JsonProperty("country_code")
    public String getCountryCode() {
        return countryCode;
    }

    @JsonProperty("country_code")
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    @JsonProperty("country_name")
    public String getCountryName() {
        return countryName;
    }

    @JsonProperty("country_name")
    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    @JsonProperty("meeting_name")
    public String getMeetingName() {
        return meetingName;
    }

    @JsonProperty("meeting_name")
    public void setMeetingName(String meetingName) {
        this.meetingName = meetingName;
    }

    @JsonProperty("meeting_official_name")
    public String getMeetingOfficialName() {
        return meetingOfficialName;
    }

    @JsonProperty("meeting_official_name")
    public void setMeetingOfficialName(String meetingOfficialName) {
        this.meetingOfficialName = meetingOfficialName;
    }

    @JsonProperty("gmt_offset")
    public String getGmtOffset() {
        return gmtOffset;
    }

    @JsonProperty("gmt_offset")
    public void setGmtOffset(String gmtOffset) {
        this.gmtOffset = gmtOffset;
    }

    @JsonProperty("date_start")
    public String getDateStart() {
        return dateStart;
    }

    @JsonProperty("date_start")
    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }

    @JsonProperty("year")
    public Integer getYear() {
        return year;
    }

    @JsonProperty("year")
    public void setYear(Integer year) {
        this.year = year;
    }

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
