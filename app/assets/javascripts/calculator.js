var autocomplete;

function initAutocomplete() {
  var options = {
    types: ['(regions)']
  }

  autocomplete = new google.maps.places.Autocomplete(document.getElementById('address'), options);
  autocomplete.addListener('place_changed', onAddressSelect);
}

function onAddressSelect() {
  var place = autocomplete.getPlace();

  document.getElementById('latitude').value = place.geometry.location.lat();
  document.getElementById('longitude').value = place.geometry.location.lng();
}
