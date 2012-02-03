<?php

function emic_show_tei($pid, $xslt) {
  $xslt_path = drupal_get_path("module", 'emic_tei') . "/xml/$xslt";
  $fedora_base = variable_get('fedora_base_url', 'http://localhost:8080/fedora');
  $file_url = "$fedora_base/objects/$pid/datastreams/TEI/content";
  $lines = @file($file_url);
  $xmlstr = '';
  foreach ($lines as $line) {
    $xmlstr .= $line;
  }
  $proc = new XsltProcessor();
  $xsl = new DomDocument();
  $xsl->load($xslt_path);
  $input = new DomDocument();
  $input->loadXML(trim($xmlstr));
  $xsl = $proc->importStylesheet($xsl);
  $newdom = $proc->transformToDoc($input);
  $content = $newdom->saveXML();
  return $content;
}

