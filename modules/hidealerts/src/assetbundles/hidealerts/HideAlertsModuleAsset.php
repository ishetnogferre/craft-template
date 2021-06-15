<?php
/**
 * SiteModule AssetBundle
 *
 * @link      https://www.marbles.be
 * @copyright Copyright (c) 2017 marbles
 */

namespace modules\hidealerts\assetbundles\hidealerts;

use Craft;
use craft\redactor\assets\redactor\RedactorAsset;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    marbles
 * @package   SiteModule
 * @since     1.0.0
 * @inheritdoc
 */
class HideAlertsModuleAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = '@modules/hidealerts/assetbundles/hidealerts/dist';

        $this->depends = [
            CpAsset::class,
        ];

        $this->css = $this->getCssArray();

        parent::init();
    }

    private function getCssArray(): array
    {
        if ($this->checkIfAlertNeedsToBeDisabled()) {
            return [
                'css/DisableAlerts.css',
            ];
        }

        return [];
    }

    private function checkIfAlertNeedsToBeDisabled(): bool
    {
        $freeformTrial = false;
        $trial = 0; 

        foreach(Craft::$app->plugins->allPlugins as $plugin) {
            $status = Craft::$app->plugins->getPluginLicenseKeyStatus($plugin->handle);

            if ($plugin->handle == 'freeform' && $status == 'trial') {
                $freeformTrial = true;
            }
            
            if ($status == 'trial') {
                $trial++;
            }
        }

        return $freeformTrial && $trial == 1;
        
    }
}
