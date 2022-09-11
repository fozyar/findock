// Response retrieved from the API, save all of this in this Data Transfer Object
public with sharing class FND_AddressResponseDTO {
    public String type {get; set;}
    public List<FeaturesDTO> features {get; set;}
    public QueryDTO query {get; set;}

    public class FeaturesDTO {
        public String type {get; set;}
        public PropertiesDTO properties {get; set;}
        public GeometryDTO geometry {get; set;}
        public List<String> bbox {get; set;}
    }

    public class PropertiesDTO {
        public DataSourceDTO datasource {get; set;}
        public String housenumber {get; set;}
        public String street {get; set;}
        public String suburb {get; set;}
        public String city {get; set;}
        public String state {get; set;}
        public String country {get; set;}
        public String postcode {get; set;}
        public String country_code {get; set;}
        public String lon {get; set;}
        public String lat {get; set;}
        public String state_code {get; set;}
        public String formatted {get; set;}
        public String address_line1 {get; set;}
        public String address_line2 {get; set;}
        public String result_type {get; set;}
        public RankDTO rank {get; set;}
        public String place_id {get; set;}
    }

    public class DataSourceDTO {
        public String sourceName {get; set;}
        public String attribution {get; set;}
        public String license {get; set;}
        public String url {get; set;}
    }

    public class RankDTO {
        public String importance {get; set;}
        public String popularity {get; set;}
        public String confidence {get; set;}
        public String confidence_city_level {get; set;}
        public String confidence_street_level {get; set;}
        public String match_type {get; set;}
    }

    public class GeometryDTO {
        public String type {get; set;}
        public List<String> coordinates {get; set;}
    }

    public class QueryDTO {
        public String text {get; set;}
        public ParsedDTO parsed {get; set;}
    }

    public class ParsedDTO {
        public String housenumber {get; set;}
        public String street {get; set;}
        public String postcode {get; set;}
        public String city {get; set;}
        public String country {get; set;}
        public String expected_type {get; set;}
    }
}
