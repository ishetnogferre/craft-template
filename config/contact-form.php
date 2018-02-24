<?php

return [
    'toEmail'             => !Craft::$app->request->isConsoleRequest ? Craft::$app->request->getValidatedBodyParam('toEmail') : '',
    'prependSubject'      => '',
    'prependSender'       => '',
    'allowAttachments'    => false,
    'successFlashMessage' => !Craft::$app->request->isConsoleRequest ? Craft::$app->request->getValidatedBodyParam('notice') : '',
];