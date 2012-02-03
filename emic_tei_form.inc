<?php

function get_tei_tab_content($pid) {
  $form['tei_page_tab'] = array(
    '#type' => 'tabpage',
    '#title' => t('TEI'),
    '#content' => drupal_get_form('emic_tei_form', $pid),
    '#selected' => FALSE,
  );
  return $form;
}

function emic_tei_form($form, $pid) {
  $path = drupal_get_path('module', 'emic_tei') . '/xml';
  $files = file_scan_directory($path, '.xsl');
  $options = array();
  foreach ($files as $file) {
    $options[$file->basename] = $file->name;
  }
  $form = array();
  $form['pid'] = array(
    '#type' => 'hidden',
    '#value' => $pid,
  );
  $form['choose_xsl'] = array(
    '#title' => t('Choose Transformation'),
    '#description' => t('Selects which xslt will be used to transform TEI'),
    '#type' => 'select',
    '#options' => $options,
  );
    $form['submit'] = array(
      '#type' => 'submit',
      '#value' => t('Create view'),

    );

  return $form;

}
function emic_tei_form_submit($form, &$form_state){
  $xsl = $form_state['values']['choose_xsl'];
  $pid = $form_state['values']['pid'];
  drupal_goto("emic/show/tei/$pid/$xsl");
}