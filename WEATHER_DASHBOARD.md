"""
Weather Dashboard Setup Documentation
"""

weather_setup_doc = """
# 🌤️ IA22 Weather Dashboard Setup Guide

## Overview

The IA22 Weather Dashboard integrates real-time weather data from OpenWeatherMap API.

## Features

✅ Real-time weather data fetching
✅ 5-day forecast
✅ Search functionality for cities
✅ GPS coordinates support
✅ Weather history tracking
✅ Favorite locations management
✅ Temperature trends analysis
✅ Interactive web dashboard

## Setup Instructions

### 1. Get API Key

1. Go to [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Get your API key from the dashboard
4. Add to `.env`:

```bash
OPENWEATHER_API_KEY=your_api_key_here
```

### 2. Database Setup

Initialize weather tables:

```bash
make db-init
```

### 3. Install Dependencies

```bash
poetry install
```

### 4. Start Server

```bash
make run-dev
```

## API Endpoints

### Get Current Weather

```bash
curl "http://localhost:8000/api/weather/current/Paris?units=metric"
```

Response:
```json
{
  "city": "Paris",
  "country": "FR",
  "temperature": 15.5,
  "feels_like": 14.0,
  "humidity": 65,
  "weather": "Partly cloudy",
  "wind_speed": 3.5
}
```

### Get Forecast

```bash
curl "http://localhost:8000/api/weather/forecast/Paris?days=5"
```

### Search Cities

```bash
curl "http://localhost:8000/api/weather/search?q=paris&limit=5"
```

### Get Weather by Coordinates

```bash
curl "http://localhost:8000/api/weather/coordinates?lat=48.8566&lon=2.3522"
```

### Get Weather History

```bash
curl "http://localhost:8000/api/weather/history/Paris?days=7"
```

### Get Temperature Trend

```bash
curl "http://localhost:8000/api/weather/trend/Paris?days=7"
```

### Manage Favorite Locations

```bash
# Get favorites
curl "http://localhost:8000/api/weather/favorites?user_id=1"

# Add favorite
curl -X POST "http://localhost:8000/api/weather/favorites?user_id=1" \\
  -H "Content-Type: application/json" \\
  -d '{
    "city": "Paris",
    "country": "FR",
    "latitude": 48.8566,
    "longitude": 2.3522,
    "display_name": "My Paris"
  }'

# Remove favorite
curl -X DELETE "http://localhost:8000/api/weather/favorites/1?user_id=1"

# Set default location
curl -X PUT "http://localhost:8000/api/weather/favorites/1/default?user_id=1"
```

## Web Dashboard

Access the dashboard at:

```
http://localhost:8000/weather/dashboard
```

Features:
- Search any city
- View current weather
- See 5-day forecast
- Manage favorite locations
- Responsive design

## Database Schema

### weather_snapshots
- Stores current weather snapshots
- Used for historical tracking
- Indexed by city and date

### weather_forecasts
- Stores 5-day forecasts
- Timestamped forecast entries
- Indexed by city and forecast time

### favorite_locations
- User favorite weather locations
- Supports default location
- Linked to users table

## Example Usage

```python
from ia22.weather.client import WeatherClient
import asyncio

async def example():
    client = WeatherClient("your_api_key")
    
    # Get current weather
    weather = await client.get_current_weather("Paris")
    print(f"Temperature: {weather['temperature']}°C")
    
    # Get forecast
    forecast = await client.get_forecast("Paris")
    print(f"Forecast items: {len(forecast['forecasts'])}")
    
    await client.close()

asyncio.run(example())
```

## Features

### Service Layer

The `WeatherService` provides business logic:

```python
from ia22.weather.service import WeatherService
from sqlalchemy.orm import Session

service = WeatherService(db)

# Save weather snapshot
service.save_weather_snapshot(weather_data)

# Save forecast
service.save_forecast(forecast_data)

# Get weather history
history = service.get_weather_history("Paris", days=7)

# Get temperature trend
trend = service.get_temperature_trend("Paris")

# Manage favorites
favorite = service.add_favorite_location(
    user_id=1,
    city="Paris",
    country="FR",
    lat=48.8566,
    lon=2.3522,
    name="My Paris"
)
```

## Performance & Caching

Use caching for repeated requests:

```python
from ia22.features import cache_manager

# Cache weather data for 1 hour
cache_manager.set(f"weather:Paris", weather_data, ttl=3600)

# Retrieve from cache
cached = cache_manager.get(f"weather:Paris")
```

## Unit Conversion

Supported units:
- `metric` - Celsius, m/s (default)
- `imperial` - Fahrenheit, mph
- `kelvin` - Kelvin, m/s

Example:

```bash
curl "http://localhost:8000/api/weather/current/Paris?units=imperial"
```

## Error Handling

All endpoints return appropriate HTTP status codes:

- `200 OK` - Successful request
- `400 Bad Request` - Invalid parameters
- `404 Not Found` - City/location not found
- `500 Internal Server Error` - Server error

## Testing

Run tests:

```bash
pytest tests/test_weather.py -v
```

## Environment Variables

```
OPENWEATHER_API_KEY=your_api_key
WEATHER_CACHE_TTL=3600
WEATHER_UNITS=metric
```

## Troubleshooting

### API Key Issues

1. Verify API key is correct
2. Check if key is activated in OpenWeatherMap
3. Ensure rate limits are not exceeded

### Database Issues

1. Run `make db-init` to create tables
2. Check database permissions
3. Verify SQLite3 is working

### Network Issues

1. Check internet connection
2. Verify OpenWeatherMap API is accessible
3. Check firewall/proxy settings

## Features Coming Soon

- Alert/notification system
- Advanced analytics
- Weather maps integration
- Multi-language support
- Weather alerts system

## References

- [OpenWeatherMap API](https://openweathermap.org/api)
- [API Documentation](https://openweathermap.org/api)
- [httpx Documentation](https://www.python-httpx.org/)

---

**Author:** Zoubirou Mohammed Ilyes  
**Version:** 1.0.0  
**Last Updated:** 2026-05-31
"""

print(weather_setup_doc)
