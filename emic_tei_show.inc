<?php

function emic_show_tei($pid, $xslt) {
  global $base_url;
  drupal_add_css(drupal_get_path('module', 'emic_tei') . '/xml/pkp.css');
  $path = drupal_get_path('module', 'emic_tei');
  $xslt_path = "$base_url/" . drupal_get_path("module", 'emic_tei') . "/xml/$xslt";
  $fedora_base = variable_get('fedora_base_url', 'http://localhost:8080/fedora');
  $xml_path = "$fedora_base/objects/$pid/datastreams/TEI/content";
  $output = l(t('Return to Transform Selecteor'), "emic/page/$pid") . "<br />";
  $output .= l(t('Return to book view'), "fedora/repository/$pid") . "<br /><br />";
  $output .= file_get_contents("http://localhost:8080/saxon/SaxonServlet?source=$xml_path&style=$xslt_path");

  return $output;
}

function emic_serve_gile($type, $identifier) {
  $fedora_base = variable_get('fedora_base_url', 'http://localhost:8080/fedora');

  if ($type == 'xml') {
    $file_path = "$fedora_base/objects/$identifier/datastreams/TEI/content";
  }
  if ($type == 'xsl') {
    $file_path = drupal_get_path("module", 'emic_tei') . "/xml/$identifier";
  }

  print file_get_contents($file_path);
}

