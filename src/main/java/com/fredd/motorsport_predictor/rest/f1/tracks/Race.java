
package com.fredd.motorsport_predictor.rest.f1.tracks;

import java.util.LinkedHashMap;
import java.util.Map;
import jakarta.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import lombok.Getter;
import lombok.Setter;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "season",
    "round",
    "url",
    "raceName",
    "Circuit",
    "date",
    "time",
    "FirstPractice",
    "SecondPractice",
    "ThirdPractice",
    "Qualifying",
    "Sprint"
})
@Generated("jsonschema2pojo")
@Getter
@Setter
public class Race {

    @JsonProperty("season")
    private String season;
    @JsonProperty("round")
    private String round;
    @JsonProperty("url")
    private String url;
    @JsonProperty("raceName")
    private String raceName;
    @JsonProperty("Circuit")
    private Circuit circuit;
    @JsonProperty("date")
    private String date;
    @JsonProperty("time")
    private String time;
    @JsonProperty("FirstPractice")
    private FirstPractice firstPractice;
    @JsonProperty("SecondPractice")
    private SecondPractice secondPractice;
    @JsonProperty("ThirdPractice")
    private ThirdPractice thirdPractice;
    @JsonProperty("Qualifying")
    private Qualifying qualifying;
    @JsonProperty("Sprint")
    private Sprint sprint;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonAnyGetter
    public Map<String, Object> getAdditionalProperties() {
        return this.additionalProperties;
    }

    @JsonAnySetter
    public void setAdditionalProperty(String name, Object value) {
        this.additionalProperties.put(name, value);
    }

}
