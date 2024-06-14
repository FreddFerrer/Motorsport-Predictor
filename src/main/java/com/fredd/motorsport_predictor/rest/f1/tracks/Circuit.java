
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

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "circuitId",
    "url",
    "circuitName",
    "Location"
})
@Generated("jsonschema2pojo")
public class Circuit {

    @JsonProperty("circuitId")
    private String circuitId;
    @JsonProperty("url")
    private String url;
    @JsonProperty("circuitName")
    private String circuitName;
    @JsonProperty("Location")
    private Location location;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonProperty("circuitId")
    public String getCircuitId() {
        return circuitId;
    }

    @JsonProperty("circuitId")
    public void setCircuitId(String circuitId) {
        this.circuitId = circuitId;
    }

    @JsonProperty("url")
    public String getUrl() {
        return url;
    }

    @JsonProperty("url")
    public void setUrl(String url) {
        this.url = url;
    }

    @JsonProperty("circuitName")
    public String getCircuitName() {
        return circuitName;
    }

    @JsonProperty("circuitName")
    public void setCircuitName(String circuitName) {
        this.circuitName = circuitName;
    }

    @JsonProperty("Location")
    public Location getLocation() {
        return location;
    }

    @JsonProperty("Location")
    public void setLocation(Location location) {
        this.location = location;
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
