var autocomplete;

function initAutocomplete() {
  var addressField = document.getElementById('address');
  var options = {
    types: ['(regions)']
  }

  autocomplete = new google.maps.places.Autocomplete(addressField, options);
  autocomplete.addListener('place_changed', onAddressSelect);

  if (addressField !== null) {
    addressField.addEventListener('keydown', onAddressKeydown);
  }
}

function onAddressKeydown(event) {
  if (event.keyCode === 13) {
    event.preventDefault(); // prevent submit when hitting enter on google suggestion
  }
}

function onAddressSelect() {
  var place = autocomplete.getPlace();

  document.getElementById('latitude').value = place.geometry.location.lat();
  document.getElementById('longitude').value = place.geometry.location.lng();
}
