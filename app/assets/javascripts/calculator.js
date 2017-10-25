var autocomplete, address, latitude, longitude, region;

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'));
  autocomplete.addListener('place_changed', onAddressSelect);
}

function onAddressSelect() {
  var place = autocomplete.getPlace();
  address = place.formatted_address;
  latitude = place.geometry.location.lat();
  longitude = place.geometry.location.lng();

  place.address_components.find(function(addressComponent) {
    if (addressComponent.types.includes('administrative_area_level_2')) {
      region = addressComponent['long_name'];
    }

    if (region === undefined && addressComponent.types.includes('political')) {
      region = addressComponent['long_name'];
    }
  });
}