Drupal.behaviors.emictei = function(context){

 $('#transformResult').text("Loading...");
  var xml = Drupal.settings.basePath + 'emic/serve/file/xml/' + Drupal.settings.xml;
  var xsl = Drupal.settings.basePath + 'emic/serve/file/xsl/' + Drupal.settings.xslt;
  var tei;
  var xslt;
  $.ajax({
    url: xml,
    async:false,
    success: function(data, status, xhr) {
      tei=data;

    },
    error: function() {
      alert("xml did not load");
    }

  });

  $.ajax({
    url: xsl,
    async:false,
    success: function(data, status, xhr) {
      xslt=data;

    },
    error: function() {
      alert("xslt did not load");
    }

  });

    var holder = $().xslt(tei, xslt);
  $('#transformResult').text('<pre>' + holder + '</pre>');
};

