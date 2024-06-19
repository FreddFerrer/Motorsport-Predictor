
package com.fredd.motorsport_predictor.rest.f1.drivers;

import java.util.LinkedHashMap;
import java.util.Map;

import com.fredd.motorsport_predictor.rest.global.MRData;
import jakarta.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonAnyGetter;
import com.fasterxml.jackson.annotation.JsonAnySetter;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "MRData"
})
@Generated("jsonschema2pojo")
public class F1DriversDto {

    @JsonProperty("MRData")
    private MRData mRData;
    @JsonIgnore
    private Map<String, Object> additionalProperties = new LinkedHashMap<String, Object>();

    @JsonProperty("MRData")
    public MRData getMRData() {
        return mRData;
    }

    @JsonProperty("MRData")
    public void setMRData(MRData mRData) {
        this.mRData = mRData;
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
