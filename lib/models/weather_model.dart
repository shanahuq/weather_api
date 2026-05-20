
class WeatherModel {
    Coord? coord;
    List<Weather>? weather;
    String? base;
    Main? main;
    int? visibility;
    Wind? wind;
    Rain? rain;
    Clouds? clouds;
    int? dt;
    Sys? sys;
    int? timezone;
    int? id;
    String? name;
    int? cod;

    WeatherModel({this.coord, this.weather, this.base, this.main, this.visibility, this.wind, this.rain, this.clouds, this.dt, this.sys, this.timezone, this.id, this.name, this.cod});

    WeatherModel.fromJson(Map<String, dynamic> json) {
        coord = json["coord"] == null ? null : Coord.fromJson(json["coord"]);
        weather = json["weather"] == null ? null : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
        base = json["base"];
        main = json["main"] == null ? null : Main.fromJson(json["main"]);
        visibility = json["visibility"];
        wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
        rain = json["rain"] == null ? null : Rain.fromJson(json["rain"]);
        clouds = json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]);
        dt = json["dt"];
        sys = json["sys"] == null ? null : Sys.fromJson(json["sys"]);
        timezone = json["timezone"];
        id = json["id"];
        name = json["name"];
        cod = json["cod"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(coord != null) {
            _data["coord"] = coord?.toJson();
        }
        if(weather != null) {
            _data["weather"] = weather?.map((e) => e.toJson()).toList();
        }
        _data["base"] = base;
        if(main != null) {
            _data["main"] = main?.toJson();
        }
        _data["visibility"] = visibility;
        if(wind != null) {
            _data["wind"] = wind?.toJson();
        }
        if(rain != null) {
            _data["rain"] = rain?.toJson();
        }
        if(clouds != null) {
            _data["clouds"] = clouds?.toJson();
        }
        _data["dt"] = dt;
        if(sys != null) {
            _data["sys"] = sys?.toJson();
        }
        _data["timezone"] = timezone;
        _data["id"] = id;
        _data["name"] = name;
        _data["cod"] = cod;
        return _data;
    }
}

class Sys {
    int? type;
    int? id;
    String? country;
    int? sunrise;
    int? sunset;

    Sys({this.type, this.id, this.country, this.sunrise, this.sunset});

    Sys.fromJson(Map<String, dynamic> json) {
        type = json["type"];
        id = json["id"];
        country = json["country"];
        sunrise = json["sunrise"];
        sunset = json["sunset"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["type"] = type;
        _data["id"] = id;
        _data["country"] = country;
        _data["sunrise"] = sunrise;
        _data["sunset"] = sunset;
        return _data;
    }
}

class Clouds {
    int? all;

    Clouds({this.all});

    Clouds.fromJson(Map<String, dynamic> json) {
        all = json["all"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["all"] = all;
        return _data;
    }
}

class Rain {
    double? oneHourRain;

    Rain({this.oneHourRain});

    Rain.fromJson(Map<String, dynamic> json) {
        oneHourRain = json["1h"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["1h"] = oneHourRain;
        return _data;
    }
}

class Wind {
    double? speed;
    int? deg;

    Wind({this.speed, this.deg});

    Wind.fromJson(Map<String, dynamic> json) {
        speed = json["speed"];
        deg = json["deg"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["speed"] = speed;
        _data["deg"] = deg;
        return _data;
    }
}
class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main.fromJson(Map<String, dynamic> json) {
    temp = (json["temp"] as num?)?.toDouble();
    feelsLike = (json["feels_like"] as num?)?.toDouble();
    tempMin = (json["temp_min"] as num?)?.toDouble();
    tempMax = (json["temp_max"] as num?)?.toDouble();

    pressure = json["pressure"];
    humidity = json["humidity"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
  }

  Map<String, dynamic> toJson() {
    return {
      "temp": temp,
      "feels_like": feelsLike,
      "temp_min": tempMin,
      "temp_max": tempMax,
      "pressure": pressure,
      "humidity": humidity,
      "sea_level": seaLevel,
      "grnd_level": grndLevel,
    };
  }
}


class Weather {
    int? id;
    String? main;
    String? description;
    String? icon;

    Weather({this.id, this.main, this.description, this.icon});

    Weather.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        main = json["main"];
        description = json["description"];
        icon = json["icon"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["main"] = main;
        _data["description"] = description;
        _data["icon"] = icon;
        return _data;
    }
}

class Coord {
    double? lon;
    double? lat;

    Coord({this.lon, this.lat});

    Coord.fromJson(Map<String, dynamic> json) {
        lon = json["lon"];
        lat = json["lat"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["lon"] = lon;
        _data["lat"] = lat;
        return _data;
    }
}