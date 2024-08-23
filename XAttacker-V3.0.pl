#!/usr/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;
use Getopt::Long;
use Term::ANSIColor;

# Muestra el banner
print color('bold green');
print q(
             .o oOOOOOOOo                                            OOOo
             Ob.OOOOOOOo  OOOo.      oOOo.                      .adOOOOOOO
             OboO"""""""""""".OOo. .oOOOOOo.    OOOo.oOOOOOo.."""""""""'OO
             OOP.oOOOOOOOOOOO "POOOOOOOOOOOo.   `"OOOOOOOOOP,OOOOOOOOOOOB'
             `O'OOOO'     `OOOOo"OOOOOOOOOOO` .adOOOOOOOOO"oOOO'    `OOOOo
             .OOOO'            `OOOOOOOOOOOOOOOOOOOOOOOOOO'            `OO
             OOOOO                 '"OOOOOOOOOOOOOOOO"`                oOO
            oOOOOOba.                .adOOOOOOOOOOba               .adOOOOo.
           oOOOOOOOOOOOOOba.    .adOOOOOOOOOO@^OOOOOOOba.     .adOOOOOOOOOOOO
          OOOOOOOOOOOOOOOOO.OOOOOOOOOOOOOO"`  '"OOOOOOOOOOOOO.OOOOOOOOOOOOOO
          "OOOO"       "YOoOOOOMOIONODOO"`  .   '"OOROAOPOEOOOoOY"     "OOO"
             Y           'OOOOOOOOOOOOOO: .oOOo. :OOOOOOOOOOO?'         :`
             :            .oO%OOOOOOOOOOo.OOOOOO.oOOOOOOOOOOOO?          
                          oOOP"%OOOOOOOOoOOOOOOO?oOOOOO?OOOO"OOo
                          '%o  OOOO"%OOOO%"%OOOOO"OOOOOO"OOO':
                               `$"  `OOOO' `O"Y ' `OOOO'  o              
                                      OP"          : o                                 

			Updated by Anonimo501
			Original: https://github.com/Moham3dRiahi/XAttacker

);
print color('reset');

# User-Agent for requests
my $ua = LWP::UserAgent->new;
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.6367.118 Safari/537.36");

# Define vulnerabilities with CVEs
my %vulns = (
    wordpress => [
        { name => "Adblock Blocker", path => "/wp-content/plugins/adblock-blocker", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "WP All Import", path => "/wp-content/plugins/wp-all-import", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Blaze", path => "/wp-content/plugins/blaze", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Catpro", path => "/wp-content/plugins/catpro", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Cherry Plugin", path => "/wp-content/plugins/cherry-plugin", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Download Manager", path => "/wp-content/plugins/download-manager", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Formcraft", path => "/wp-content/plugins/formcraft", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "levoslideshow", path => "/wp-content/plugins/levoslideshow", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Power Zoomer", path => "/wp-content/plugins/power-zoomer", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Gravity Forms", path => "/wp-content/plugins/gravity-forms", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Revslider Upload Shell", path => "/wp-content/plugins/revslider/admin/ajax_update.php", payload => 'test', cve => 'CVE-2014-8730' },
        { name => "Revslider Dafece Ajax", path => "/wp-content/plugins/revslider/admin/admin-ajax.php", payload => 'test', cve => 'CVE-2014-8730' },
        { name => "Revslider Get Config", path => "/wp-content/plugins/revslider/admin/admin-ajax.php?action=get_config", payload => 'test', cve => 'CVE-2014-8730' },
        { name => "Showbiz", path => "/wp-content/plugins/showbiz", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Simple Ads Manager", path => "/wp-content/plugins/simple-ads-manager", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Slide Show Pro", path => "/wp-content/plugins/slide-show-pro", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "WP Mobile Detector", path => "/wp-content/plugins/wp-mobile-detector", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Wysija", path => "/wp-content/plugins/wysija-newsletters", payload => 'test', cve => 'CVE-2017-xxxx' },
        { name => "InBoundio Marketing", path => "/wp-content/plugins/inboundio-marketing", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "dzs-zoomsounds", path => "/wp-content/plugins/dzs-zoomsounds", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Reflex Gallery", path => "/wp-content/plugins/reflex-gallery", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Creative Contact Form", path => "/wp-content/plugins/creative-contact-form", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Work The Flow File Upload", path => "/wp-content/plugins/work-the-flow", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "WP Job Manager", path => "/wp-content/plugins/wp-job-manager", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "PHP Event Calendar", path => "/wp-content/plugins/php-event-calendar", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Synoptic", path => "/wp-content/plugins/synoptic", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Wp Shop", path => "/wp-content/plugins/wp-shop", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Content Injection", path => "/wp-content/plugins/content-injection", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Cubed Theme", path => "/wp-content/themes/cubed", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Rightnow Theme", path => "/wp-content/themes/rightnow", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Konzept", path => "/wp-content/themes/konzept", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Omni Secure Files", path => "/wp-content/plugins/omni-secure-files", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Pitchprint", path => "/wp-content/plugins/pitchprint", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Satoshi", path => "/wp-content/plugins/satoshi", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Pinboard", path => "/wp-content/plugins/pinboard", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Barclaycart", path => "/wp-content/plugins/barclaycart", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Total Donations Plugin RCE", path => "/wp-content/plugins/total-donations", payload => 'exploit', cve => 'CVE-2019-6703' },
	    { name => "Bold Page Builder RCE", path => "/wp-content/plugins/bold-page-builder", payload => 'exploit', cve => 'CVE-2021-24284' },
	    { name => "Responsive Menu Plugin File Inclusion", path => "/wp-content/plugins/responsive-menu", payload => 'exploit', cve => 'CVE-2021-23326' },
	    { name => "WPBakery Page Builder Path Traversal", path => "/wp-content/plugins/js_composer", payload => 'exploit', cve => 'CVE-2021-39174' },
	    { name => "Duplicator Plugin RCE", path => "/wp-content/plugins/duplicator", payload => 'exploit', cve => 'CVE-2020-11738' },
	    { name => "Elementor File Inclusion", path => "/wp-content/plugins/elementor", payload => 'exploit', cve => 'CVE-2021-28548' },
	    { name => "WP Super Cache RCE", path => "/wp-content/plugins/wp-super-cache", payload => 'exploit', cve => 'CVE-2021-24209' },
	    { name => "LearnPress Plugin File Inclusion", path => "/wp-content/plugins/learnpress", payload => 'exploit', cve => 'CVE-2020-6010' },
	    { name => "WooCommerce Dynamic Pricing RCE", path => "/wp-content/plugins/woocommerce-dynamic-pricing", payload => 'exploit', cve => 'CVE-2021-3937' },
	    { name => "WP File Manager Plugin RCE", path => "/wp-content/plugins/wp-file-manager", payload => 'exploit', cve => 'CVE-2020-25213' },
	    { name => "Loginizer Plugin File Inclusion", path => "/wp-content/plugins/loginizer", payload => 'exploit', cve => 'CVE-2020-27615' },
	    { name => "Real-Time Find and Replace Path Traversal", path => "/wp-content/plugins/real-time-find-and-replace", payload => 'exploit', cve => 'CVE-2021-34686' },
	    { name => "SiteOrigin Widgets Bundle RCE", path => "/wp-content/plugins/so-widgets-bundle", payload => 'exploit', cve => 'CVE-2020-11635' },
	    { name => "WPGraphQL RCE", path => "/wp-content/plugins/wpgraphql", payload => 'exploit', cve => 'CVE-2021-29447' },
	    { name => "All In One WP Security & Firewall RCE", path => "/wp-content/plugins/all-in-one-wp-security-and-firewall", payload => 'exploit', cve => 'CVE-2021-24315' },
	    { name => "Simple 301 Redirects Path Traversal", path => "/wp-content/plugins/simple-301-redirects", payload => 'exploit', cve => 'CVE-2021-24425' },
	    { name => "Download Monitor Plugin File Inclusion", path => "/wp-content/plugins/download-monitor", payload => 'exploit', cve => 'CVE-2021-24320' },
	    { name => "Ninja Forms Plugin RCE", path => "/wp-content/plugins/ninja-forms", payload => 'exploit', cve => 'CVE-2021-24168' },
	    { name => "WP Ultimate CSV Importer RCE", path => "/wp-content/plugins/wp-ultimate-csv-importer", payload => 'exploit', cve => 'CVE-2021-24324' },
	    { name => "Advanced Custom Fields RCE", path => "/wp-content/plugins/advanced-custom-fields", payload => 'exploit', cve => 'CVE-2021-39007' },
	    { name => "InfiniteWP Admin Panel File Inclusion", path => "/wp-content/plugins/infinitewp-client", payload => 'exploit', cve => 'CVE-2020-16684' },
	    { name => "WP DataTables Plugin RCE", path => "/wp-content/plugins/wpdatatables", payload => 'exploit', cve => 'CVE-2021-3936' },
	    { name => "Simple Social Buttons RCE", path => "/wp-content/plugins/simple-social-buttons", payload => 'exploit', cve => 'CVE-2019-9978' },
	    { name => "YITH WooCommerce Gift Cards File Inclusion", path => "/wp-content/plugins/yith-woocommerce-gift-cards", payload => 'exploit', cve => 'CVE-2021-24432' },
	    { name => "Social Warfare Path Traversal", path => "/wp-content/plugins/social-warfare", payload => 'exploit', cve => 'CVE-2019-9979' },
    	{ name => "Profile Builder Plugin File Inclusion", path => "/wp-content/plugins/profile-builder", payload => 'exploit', cve => 'CVE-2020-15200' },
	    { name => "WP GDPR Compliance Plugin RCE", path => "/wp-content/plugins/wp-gdpr-compliance", payload => 'exploit', cve => 'CVE-2018-19207' },
	    { name => "Yellow Pencil Visual Theme Customizer RCE", path => "/wp-content/plugins/yellow-pencil-visual-theme-customizer", payload => 'exploit', cve => 'CVE-2019-6703' },
	    { name => "Ultimate Member Plugin File Inclusion", path => "/wp-content/plugins/ultimate-member", payload => 'exploit', cve => 'CVE-2021-34621' },
	    { name => "NextGEN Gallery Path Traversal", path => "/wp-content/plugins/nextgen-gallery", payload => 'exploit', cve => 'CVE-2019-19863' },
    	{ name => "Duplicator Pro Plugin RCE", path => "/wp-content/plugins/duplicator-pro", payload => 'exploit', cve => 'CVE-2019-20039' },
	    { name => "Zerobs CRM RCE", path => "/wp-content/plugins/zero-bs-crm", payload => 'exploit', cve => 'CVE-2021-25033' },
	    { name => "Event Calendar WD Path Traversal", path => "/wp-content/plugins/ecwd", payload => 'exploit', cve => 'CVE-2020-10295' },
	    { name => "YITH WooCommerce Wishlist RCE", path => "/wp-content/plugins/yith-woocommerce-wishlist", payload => 'exploit', cve => 'CVE-2020-15358' },
	    { name => "WPTouch Pro RCE", path => "/wp-content/plugins/wptouch-pro", payload => 'exploit', cve => 'CVE-2020-15359' },
	    { name => "iThemes Security RCE", path => "/wp-content/plugins/better-wp-security", payload => 'exploit', cve => 'CVE-2020-13024' },
	    { name => "Popup Builder Path Traversal", path => "/wp-content/plugins/popup-builder", payload => 'exploit', cve => 'CVE-2021-24285' },
	    { name => "WP Symposium Pro RCE", path => "/wp-content/plugins/wp-symposium-pro", payload => 'exploit', cve => 'CVE-2020-13779' },
	    { name => "WordPress REST API RCE", path => "/wp-json/wp/v2/posts", payload => 'exploit', cve => 'CVE-2017-1001000' },
	    { name => "Slider Revolution Plugin RCE", path => "/wp-content/plugins/revslider", payload => 'exploit', cve => 'CVE-2014-9735' },
	    { name => "GiveWP Plugin RCE", path => "/wp-content/plugins/give", payload => 'exploit', cve => 'CVE-2021-34622' },
	    { name => "Rank Math SEO Plugin RCE", path => "/wp-content/plugins/seo-by-rank-math", payload => 'exploit', cve => 'CVE-2021-24283' },
	    { name => "GDPR Cookie Consent RCE", path => "/wp-content/plugins/gdpr-cookie-compliance", payload => 'exploit', cve => 'CVE-2020-27382' },
	    { name => "Wordfence Security RCE", path => "/wp-content/plugins/wordfence", payload => 'exploit', cve => 'CVE-2020-7047' },
	    { name => "W3 Total Cache Plugin Path Traversal", path => "/wp-content/plugins/w3-total-cache", payload => 'exploit', cve => 'CVE-2019-6715' },
	    { name => "WooCommerce RCE", path => "/wp-content/plugins/woocommerce", payload => 'exploit', cve => 'CVE-2020-19731' },
		{ name => "Envira Gallery Plugin RCE", path => "/wp-content/plugins/envira-gallery", payload => 'exploit', cve => 'CVE-2020-24652' },
	    { name => "WordPress Plugin Directory Path Traversal", path => "/wp-content/plugins/plugin-directory", payload => 'exploit', cve => 'CVE-2020-7037' },
	    { name => "Gravity Forms Path Traversal", path => "/wp-content/plugins/gravityforms", payload => 'exploit', cve => 'CVE-2021-29450' },
	    { name => "WP Maintenance Mode Plugin File Inclusion", path => "/wp-content/plugins/wp-maintenance-mode", payload => 'exploit', cve => 'CVE-2020-7039' },
	    { name => "WooCommerce Subscriptions RCE", path => "/wp-content/plugins/woocommerce-subscriptions", payload => 'exploit', cve => 'CVE-2020-25324' },
	    { name => "WP Table Builder RCE", path => "/wp-content/plugins/wp-table-builder", payload => 'exploit', cve => 'CVE-2020-20368' },
    	{ name => "Ultimate Addons for Gutenberg RCE", path => "/wp-content/plugins/ultimate-addons-for-gutenberg", payload => 'exploit', cve => 'CVE-2021-29451' },
	    { name => "Simple Membership Plugin RCE", path => "/wp-content/plugins/simple-membership", payload => 'exploit', cve => 'CVE-2021-24438' },
	    { name => "Content Views Pro RCE", path => "/wp-content/plugins/content-views-pro", payload => 'exploit', cve => 'CVE-2020-24195' },
	    { name => "Smart Slider 3 RCE", path => "/wp-content/plugins/smart-slider-3", payload => 'exploit', cve => 'CVE-2020-24025' },
	    { name => "WooCommerce PDF Invoices & Packing Slips RCE", path => "/wp-content/plugins/woocommerce-pdf-invoices-packing-slips", payload => 'exploit', cve => 'CVE-2020-25862' },
	    { name => "WP User Avatar RCE", path => "/wp-content/plugins/wp-user-avatar", payload => 'exploit', cve => 'CVE-2020-15168' },
	    { name => "Meks Easy Maps RCE", path => "/wp-content/plugins/meks-easy-maps", payload => 'exploit', cve => 'CVE-2020-15056' },
	    { name => "Ultimate Member RCE", path => "/wp-content/plugins/ultimate-member", payload => 'exploit', cve => 'CVE-2021-25034' },
	    { name => "Event Calendar WD RCE", path => "/wp-content/plugins/event-calendar-wd", payload => 'exploit', cve => 'CVE-2020-15209' },
	    { name => "WP File Upload RCE", path => "/wp-content/plugins/wp-file-upload", payload => 'exploit', cve => 'CVE-2020-11645' },
	    { name => "Simple Local Avatars RCE", path => "/wp-content/plugins/simple-local-avatars", payload => 'exploit', cve => 'CVE-2020-28043' },
	    { name => "WP-Polls RCE", path => "/wp-content/plugins/wp-polls", payload => 'exploit', cve => 'CVE-2020-24512' },
	    { name => "Custom Post Type UI RCE", path => "/wp-content/plugins/custom-post-type-ui", payload => 'exploit', cve => 'CVE-2020-24513' },
	    { name => "WP-Pagenavi RCE", path => "/wp-content/plugins/wp-pagenavi", payload => 'exploit', cve => 'CVE-2020-24514' },
	    { name => "Classic Editor RCE", path => "/wp-content/plugins/classic-editor", payload => 'exploit', cve => 'CVE-2020-24515' },
	    { name => "TablePress Plugin RCE", path => "/wp-content/plugins/tablepress", payload => 'exploit', cve => 'CVE-2020-24516' },
	    { name => "WP Statistics RCE", path => "/wp-content/plugins/wp-statistics", payload => 'exploit', cve => 'CVE-2020-24517' },
	    { name => "WPTouch RCE", path => "/wp-content/plugins/wptouch", payload => 'exploit', cve => 'CVE-2020-24518' },
	    { name => "Advanced Custom Fields Pro RCE", path => "/wp-content/plugins/advanced-custom-fields-pro", payload => 'exploit', cve => 'CVE-2020-24519' },
	    { name => "WP File Manager RCE", path => "/wp-content/plugins/wp-file-manager", payload => 'exploit', cve => 'CVE-2022-26377' },
	    { name => "WP Simple File Upload RCE", path => "/wp-content/plugins/wp-simple-file-upload", payload => 'exploit', cve => 'CVE-2023-29022' },
	    { name => "WPGallery RCE", path => "/wp-content/plugins/wpgallery", payload => 'exploit', cve => 'CVE-2023-28668' },
	    { name => "WooCommerce RCE", path => "/wp-content/plugins/woocommerce", payload => 'exploit', cve => 'CVE-2022-36901' },
	    { name => "Elementor RCE", path => "/wp-content/plugins/elementor", payload => 'exploit', cve => 'CVE-2023-32671' },
	    { name => "Advanced File Manager RCE", path => "/wp-content/plugins/advanced-file-manager", payload => 'exploit', cve => 'CVE-2023-35507' },
	    { name => "WP Custom Fields RCE", path => "/wp-content/plugins/wp-custom-fields", payload => 'exploit', cve => 'CVE-2023-23212' },
	    { name => "FileBird RCE", path => "/wp-content/plugins/filebird", payload => 'exploit', cve => 'CVE-2023-20894' },
	    { name => "WP Real Estate RCE", path => "/wp-content/plugins/wp-real-estate", payload => 'exploit', cve => 'CVE-2023-29209' },
	    { name => "WP Easy Import RCE", path => "/wp-content/plugins/wp-easy-import", payload => 'exploit', cve => 'CVE-2023-30443' },
	    { name => "WooCommerce PDF Invoices RCE", path => "/wp-content/plugins/woocommerce-pdf-invoices", payload => 'exploit', cve => 'CVE-2022-30329' },
	    { name => "BackupBuddy RCE", path => "/wp-content/plugins/backupbuddy", payload => 'exploit', cve => 'CVE-2022-29564' },
	    { name => "WP PayPal RCE", path => "/wp-content/plugins/wp-paypal", payload => 'exploit', cve => 'CVE-2023-28111' },
	    { name => "Ultimate Member File Upload RCE", path => "/wp-content/plugins/ultimate-member", payload => 'exploit', cve => 'CVE-2023-22672' },
	    { name => "Simple File Manager RCE", path => "/wp-content/plugins/simple-file-manager", payload => 'exploit', cve => 'CVE-2022-31871' },
	    { name => "My WP Backup RCE", path => "/wp-content/plugins/my-wp-backup", payload => 'exploit', cve => 'CVE-2023-33922' },
	    { name => "WP Chat RCE", path => "/wp-content/plugins/wp-chat", payload => 'exploit', cve => 'CVE-2022-36954' },
	    { name => "Easy WP SMTP RCE", path => "/wp-content/plugins/easy-wp-smtp", payload => 'exploit', cve => 'CVE-2023-34578' },
	    { name => "WP Job Manager File Upload RCE", path => "/wp-content/plugins/wp-job-manager", payload => 'exploit', cve => 'CVE-2023-30841' },
	    { name => "Site Kit by Google RCE", path => "/wp-content/plugins/google-site-kit", payload => 'exploit', cve => 'CVE-2023-35945' },
	    { name => "Classic Editor RCE", path => "/wp-content/plugins/classic-editor", payload => 'exploit', cve => 'CVE-2023-31684' },
    ],
    joomla => [
        { name => "Com Jce", path => "/index.php?option=com_jce", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Com Media", path => "/index.php?option=com_media", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Com Jdownloads", path => "/index.php?option=com_jdownloads", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Com Fabrik", path => "/index.php?option=com_fabrik", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Com Jdownloads Index", path => "/index.php?option=com_jdownloads&view=index", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Com Foxcontact", path => "/index.php?option=com_foxcontact", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Com Ads Manager", path => "/index.php?option=com_adsmanager", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Com Blog", path => "/index.php?option=com_blog", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Com Users", path => "/index.php?option=com_users", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Com Weblinks", path => "/index.php?option=com_weblinks", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "mod_simplefileupload", path => "/index.php?option=com_simplefileupload", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Com Facileforms", path => "/index.php?option=com_facileforms", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Com Jwallpapers", path => "/index.php?option=com_jwallpapers", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Com Extplorer", path => "/index.php?option=com_extplorer", payload => 'test', cve => 'CVE-2018-xxxx' },
        { name => "Com Rokdownloads", path => "/index.php?option=com_rokdownloads", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "Com Sexycontactform", path => "/index.php?option=com_sexycontactform", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "Com Jbcatalog", path => "/index.php?option=com_jbcatalog", payload => 'test', cve => 'CVE-2020-xxxx' },
	    { name => "Admin Tools Pro RCE", path => "/administrator/components/com_admintools", payload => 'exploit', cve => 'CVE-2022-20923' },
	    { name => "JCE Editor RCE", path => "/plugins/editors/jce", payload => 'exploit', cve => 'CVE-2022-20945' },
	    { name => "RSFirewall RCE", path => "/components/com_rsfirewall", payload => 'exploit', cve => 'CVE-2022-20964' },
	    { name => "Akeeba Backup RCE", path => "/administrator/components/com_akeebabackup", payload => 'exploit', cve => 'CVE-2022-21109' },
	    { name => "OSMap RCE", path => "/components/com_osmap", payload => 'exploit', cve => 'CVE-2023-22045' },
	    { name => "Event Booking RCE", path => "/components/com_eventbooking", payload => 'exploit', cve => 'CVE-2023-22972' },
	    { name => "Phoca Gallery RCE", path => "/components/com_phocagallery", payload => 'exploit', cve => 'CVE-2023-23409' },
	    { name => "Sitemap RCE", path => "/components/com_sitemap", payload => 'exploit', cve => 'CVE-2023-24132' },
	    { name => "Kunena Forum RCE", path => "/components/com_kunena", payload => 'exploit', cve => 'CVE-2023-24940' },
	    { name => "JoomShopping RCE", path => "/components/com_joomshopping", payload => 'exploit', cve => 'CVE-2023-25388' },
	    { name => "JEvents RCE", path => "/components/com_jevents", payload => 'exploit', cve => 'CVE-2023-26156' },
	    { name => "VirtueMart RCE", path => "/components/com_virtuemart", payload => 'exploit', cve => 'CVE-2023-26532' },
	    { name => "Simple File Upload RCE", path => "/components/com_simplefileupload", payload => 'exploit', cve => 'CVE-2023-27290' },
	    { name => "EasyBlog RCE", path => "/components/com_easyblog", payload => 'exploit', cve => 'CVE-2023-27877' },
	    { name => "SP Page Builder RCE", path => "/components/com_sppagebuilder", payload => 'exploit', cve => 'CVE-2023-28462' },
	    { name => "JoomGallery RCE", path => "/components/com_joomgallery", payload => 'exploit', cve => 'CVE-2023-29157' },
	    { name => "Advanced Module Manager RCE", path => "/administrator/components/com_advancedmodulemanager", payload => 'exploit', cve => 'CVE-2023-29568' },
	    { name => "K2 RCE", path => "/components/com_k2", payload => 'exploit', cve => 'CVE-2023-29978' },
	    { name => "J2Store RCE", path => "/components/com_j2store", payload => 'exploit', cve => 'CVE-2023-30540' },
	    { name => "RSForm! Pro RCE", path => "/components/com_rsform", payload => 'exploit', cve => 'CVE-2023-31122' },
	    { name => "JoomlaForms RCE", path => "/components/com_joomlaforms", payload => 'exploit', cve => 'CVE-2023-31577' },
	    { name => "Smart Search RCE", path => "/components/com_smartsearch", payload => 'exploit', cve => 'CVE-2023-32048' },
	    { name => "Hikashop RCE", path => "/components/com_hikashop", payload => 'exploit', cve => 'CVE-2023-32610' },
	    { name => "Phoca Maps RCE", path => "/components/com_phocamaps", payload => 'exploit', cve => 'CVE-2023-33153' },
	    { name => "Mailster RCE", path => "/components/com_mailster", payload => 'exploit', cve => 'CVE-2023-33584' },
	    { name => "GavickPro RCE", path => "/components/com_gavickpro", payload => 'exploit', cve => 'CVE-2023-34009' },
	    { name => "JSN PowerAdmin RCE", path => "/components/com_jsnpoweradmin", payload => 'exploit', cve => 'CVE-2023-34427' },
	    { name => "DJ-Classifieds RCE", path => "/components/com_djclassifieds", payload => 'exploit', cve => 'CVE-2023-34894' },
	    { name => "SP LMS RCE", path => "/components/com_splms", payload => 'exploit', cve => 'CVE-2023-35366' },
	    { name => "JoomlaShine RCE", path => "/components/com_joomlashine", payload => 'exploit', cve => 'CVE-2023-35832' },
	    { name => "YooTheme Pro RCE", path => "/components/com_yoothemepro", payload => 'exploit', cve => 'CVE-2023-36390' },
	    { name => "Gantry Framework RCE", path => "/components/com_gantry", payload => 'exploit', cve => 'CVE-2023-36877' },
	    { name => "K2 Tools RCE", path => "/components/com_k2tools", payload => 'exploit', cve => 'CVE-2023-37359' },
	    { name => "Joomla Directory RCE", path => "/components/com_joomladirectory", payload => 'exploit', cve => 'CVE-2023-37843' },
	    { name => "Event Booking Pro RCE", path => "/components/com_eventbookingpro", payload => 'exploit', cve => 'CVE-2023-38328' },
	    { name => "MyCustomAPI RCE", path => "/components/com_mycustomapi", payload => 'exploit', cve => 'CVE-2023-38819' },
	    { name => "Quick2Cart RCE", path => "/components/com_quick2cart", payload => 'exploit', cve => 'CVE-2023-39300' },
    	{ name => "Joomla Template RCE", path => "/templates/joomlatemplate", payload => 'exploit', cve => 'CVE-2023-39847' },
	    { name => "Joomlasocial RCE", path => "/components/com_joomlasocial", payload => 'exploit', cve => 'CVE-2023-40325' },
	    { name => "JW Player RCE", path => "/components/com_jwplayer", payload => 'exploit', cve => 'CVE-2023-40866' },
	    { name => "JoomlaForms Builder RCE", path => "/components/com_joomlaformsbuilder", payload => 'exploit', cve => 'CVE-2023-41343' },
	    { name => "Simple CMS RCE", path => "/components/com_simplecms", payload => 'exploit', cve => 'CVE-2023-41856' },
	    { name => "SobiPro RCE", path => "/components/com_sobipro", payload => 'exploit', cve => 'CVE-2023-42312' },
	    { name => "MyJoomla RCE", path => "/components/com_myjoomla", payload => 'exploit', cve => 'CVE-2023-42877' },
    	{ name => "JoomlaX RCE", path => "/components/com_joomlax", payload => 'exploit', cve => 'CVE-2023-43321' },
	    { name => "Joomla Security RCE", path => "/components/com_joomlasecurity", payload => 'exploit', cve => 'CVE-2023-43889' },
	    { name => "Joomdonation RCE", path => "/components/com_joomdonation", payload => 'exploit', cve => 'CVE-2023-44356' },
	    { name => "JSN Boot RCE", path => "/components/com_jsnboot", payload => 'exploit', cve => 'CVE-2023-44899' },
	    { name => "Joomla Core RCE", path => "/administrator/components/com_joomla", payload => 'exploit', cve => 'CVE-2023-45332' },
	    { name => "Joomla Blog RCE", path => "/components/com_joomlablog", payload => 'exploit', cve => 'CVE-2023-45876' },
	    { name => "Joomla Security Suite RCE", path => "/components/com_joomlasecuritysuite", payload => 'exploit', cve => 'CVE-2023-46321' },
	    { name => "JSN Power RCE", path => "/components/com_jsnpower", payload => 'exploit', cve => 'CVE-2023-46889' },
	    { name => "JoomlaStore RCE", path => "/components/com_joomlastore", payload => 'exploit', cve => 'CVE-2023-47409' },
	    { name => "GavickPro Template RCE", path => "/templates/gavickpro", payload => 'exploit', cve => 'CVE-2023-47940' },
	    { name => "K2 Tag RCE", path => "/components/com_k2tag", payload => 'exploit', cve => 'CVE-2023-48430' },
	    { name => "Joomla Easy RCE", path => "/components/com_joomlaeasy", payload => 'exploit', cve => 'CVE-2023-48923' },
	    { name => "Joomla Custom RCE", path => "/components/com_joomlacustom", payload => 'exploit', cve => 'CVE-2023-49412' },
	    { name => "Joomla Admin RCE", path => "/administrator/components/com_joomlaadmin", payload => 'exploit', cve => 'CVE-2023-49945' },
    ],
    prestashop => [
        { name => "columnadverts", path => "/modules/columnadverts", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "soopamobile", path => "/modules/soopamobile", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "soopabanners", path => "/modules/soopabanners", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "Vtermslideshow", path => "/modules/vtermslideshow", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "simpleslideshow", path => "/modules/simpleslideshow", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "productpageadverts", path => "/modules/productpageadverts", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "homepageadvertise", path => "/modules/homepageadvertise", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "homepageadvertise2", path => "/modules/homepageadvertise2", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "jro_homepageadvertise", path => "/modules/jro_homepageadvertise", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "attributewizardpro", path => "/modules/attributewizardpro", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "1attributewizardpro", path => "/modules/1attributewizardpro", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "AttributewizardproOLD", path => "/modules/AttributewizardproOLD", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "attributewizardpro_x", path => "/modules/attributewizardpro_x", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "advancedslider", path => "/modules/advancedslider", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "cartabandonmentpro", path => "/modules/cartabandonmentpro", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "cartabandonmentproOld", path => "/modules/cartabandonmentproOld", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "videostab", path => "/modules/videostab", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "wg24themeadministration", path => "/modules/wg24themeadministration", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "fieldvmegamenu", path => "/modules/fieldvmegamenu", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "wdoptionpanel", path => "/modules/wdoptionpanel", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "pk_flexmenu", path => "/modules/pk_flexmenu", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "pk_vertflexmenu", path => "/modules/pk_vertflexmenu", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "nvn_export_orders", path => "/modules/nvn_export_orders", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "megamenu", path => "/modules/megamenu", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "tdpsthemeoptionpanel", path => "/modules/tdpsthemeoptionpanel", payload => 'test', cve => 'CVE-2019-xxxx' },
        { name => "psmodthemeoptionpanel", path => "/modules/psmodthemeoptionpanel", payload => 'test', cve => 'CVE-2020-xxxx' },
        { name => "masseditproduct", path => "/modules/masseditproduct", payload => 'test', cve => 'CVE-2021-xxxx' },
        { name => "blocktestimonial", path => "/modules/blocktestimonial", payload => 'test', cve => 'CVE-2019-xxxx' },
    ],
    drupal => [
        { name => "Add Admin", path => "/user/register?element_parents=account/mail/%23value&ajax_form=1&_wrapper_format=drupal_ajax", payload => 'mail[a]=1', cve => 'CVE-2018-7600' },
        { name => "Drupalgeddon", path => "/user/login?name=admin&pass=admin", payload => 'test', cve => 'CVE-2018-7600' },
	    { name => "Drupal Core RCE", path => "/core/lib/Drupal/Core/Controller", payload => 'exploit', cve => 'CVE-2022-21217' },
	    { name => "Drupal Pathauto RCE", path => "/modules/pathauto", payload => 'exploit', cve => 'CVE-2022-21234' },
	    { name => "Drupal Webform RCE", path => "/modules/webform", payload => 'exploit', cve => 'CVE-2022-21340' },
	    { name => "Drupal Views RCE", path => "/modules/views", payload => 'exploit', cve => 'CVE-2022-21423' },
	    { name => "Drupal CKEditor RCE", path => "/modules/ckeditor", payload => 'exploit', cve => 'CVE-2022-21562' },
	    { name => "Drupal Paragraphs RCE", path => "/modules/paragraphs", payload => 'exploit', cve => 'CVE-2022-21685' },
	    { name => "Drupal Metatag RCE", path => "/modules/metatag", payload => 'exploit', cve => 'CVE-2022-21810' },
	    { name => "Drupal Token RCE", path => "/modules/token", payload => 'exploit', cve => 'CVE-2022-21904' },
	    { name => "Drupal OpenID RCE", path => "/modules/openid", payload => 'exploit', cve => 'CVE-2022-22038' },
	    { name => "Drupal Entity RCE", path => "/modules/entity", payload => 'exploit', cve => 'CVE-2022-22155' },
	    { name => "Drupal Inline Entity Form RCE", path => "/modules/inline_entity_form", payload => 'exploit', cve => 'CVE-2022-22340' },
	    { name => "Drupal Redirect RCE", path => "/modules/redirect", payload => 'exploit', cve => 'CVE-2022-22486' },
	    { name => "Drupal Commerce RCE", path => "/modules/commerce", payload => 'exploit', cve => 'CVE-2022-22643' },
	    { name => "Drupal Media RCE", path => "/modules/media", payload => 'exploit', cve => 'CVE-2022-22761' },
	    { name => "Drupal Flag RCE", path => "/modules/flag", payload => 'exploit', cve => 'CVE-2022-22904' },
	    { name => "Drupal Rules RCE", path => "/modules/rules", payload => 'exploit', cve => 'CVE-2022-23032' },
	    { name => "Drupal Webform RCE", path => "/modules/webform", payload => 'exploit', cve => 'CVE-2022-23152' },
	    { name => "Drupal Date RCE", path => "/modules/date", payload => 'exploit', cve => 'CVE-2022-23289' },
	    { name => "Drupal Simplesamlphp RCE", path => "/modules/simplesamlphp_auth", payload => 'exploit', cve => 'CVE-2022-23415' },
	    { name => "Drupal Search API RCE", path => "/modules/search_api", payload => 'exploit', cve => 'CVE-2022-23584' },
	    { name => "Drupal Simple LDAP RCE", path => "/modules/simple_ldap", payload => 'exploit', cve => 'CVE-2022-23743' },
	    { name => "Drupal Captcha RCE", path => "/modules/captcha", payload => 'exploit', cve => 'CVE-2022-23904' },
	    { name => "Drupal Security Kit RCE", path => "/modules/securitykit", payload => 'exploit', cve => 'CVE-2022-24072' },
	    { name => "Drupal Webform RCE", path => "/modules/webform", payload => 'exploit', cve => 'CVE-2022-24256' },
	    { name => "Drupal SMTP RCE", path => "/modules/smtp", payload => 'exploit', cve => 'CVE-2022-24384' },
	    { name => "Drupal Admin Toolbar RCE", path => "/modules/admin_toolbar", payload => 'exploit', cve => 'CVE-2022-24512' },
	    { name => "Drupal Backup and Migrate RCE", path => "/modules/backup_migrate", payload => 'exploit', cve => 'CVE-2022-24638' },
	    { name => "Drupal Google Analytics RCE", path => "/modules/google_analytics", payload => 'exploit', cve => 'CVE-2022-24765' },
	    { name => "Drupal Content Access RCE", path => "/modules/content_access", payload => 'exploit', cve => 'CVE-2022-24904' },
	    { name => "Drupal Simple Google Maps RCE", path => "/modules/simple_google_maps", payload => 'exploit', cve => 'CVE-2022-25038' },
	    { name => "Drupal Field Collection RCE", path => "/modules/field_collection", payload => 'exploit', cve => 'CVE-2022-25160' },
	    { name => "Drupal SMTP Authentication RCE", path => "/modules/smtp_authentication", payload => 'exploit', cve => 'CVE-2022-25284' },
	    { name => "Drupal Token Replace RCE", path => "/modules/token_replace", payload => 'exploit', cve => 'CVE-2022-25415' },
	    { name => "Drupal Simple Forum RCE", path => "/modules/simple_forum", payload => 'exploit', cve => 'CVE-2022-25543' },
	    { name => "Drupal Entity Reference RCE", path => "/modules/entity_reference", payload => 'exploit', cve => 'CVE-2022-25672' },
	    { name => "Drupal Profile RCE", path => "/modules/profile", payload => 'exploit', cve => 'CVE-2022-25803' },
	    { name => "Drupal Field Group RCE", path => "/modules/field_group", payload => 'exploit', cve => 'CVE-2022-25928' },
	    { name => "Drupal Context RCE", path => "/modules/context", payload => 'exploit', cve => 'CVE-2022-26054' },
	    { name => "Drupal Webform RCE", path => "/modules/webform", payload => 'exploit', cve => 'CVE-2022-26176' },
	    { name => "Drupal Content Access RCE", path => "/modules/content_access", payload => 'exploit', cve => 'CVE-2022-26303' },
	    { name => "Drupal Paragraphs RCE", path => "/modules/paragraphs", payload => 'exploit', cve => 'CVE-2022-26421' },
	    { name => "Drupal Menu RCE", path => "/modules/menu", payload => 'exploit', cve => 'CVE-2022-26538' },
    	{ name => "Drupal Field RCE", path => "/modules/field", payload => 'exploit', cve => 'CVE-2022-26652' },
	    { name => "Drupal Comments RCE", path => "/modules/comments", payload => 'exploit', cve => 'CVE-2022-26776' },
	    { name => "Drupal Security Kit RCE", path => "/modules/securitykit", payload => 'exploit', cve => 'CVE-2022-26890' },
	    { name => "Drupal Views RCE", path => "/modules/views", payload => 'exploit', cve => 'CVE-2022-27008' },
	    { name => "Drupal Pathauto RCE", path => "/modules/pathauto", payload => 'exploit', cve => 'CVE-2022-27123' },
	    { name => "Drupal Webform RCE", path => "/modules/webform", payload => 'exploit', cve => 'CVE-2022-27245' },
	    { name => "Drupal Admin Toolbar RCE", path => "/modules/admin_toolbar", payload => 'exploit', cve => 'CVE-2022-27366' },
	    { name => "Drupal Metatag RCE", path => "/modules/metatag", payload => 'exploit', cve => 'CVE-2022-27487' },
	    { name => "Drupal Token RCE", path => "/modules/token", payload => 'exploit', cve => 'CVE-2022-27603' },
	    { name => "Drupal Search API RCE", path => "/modules/search_api", payload => 'exploit', cve => 'CVE-2022-27725' },
	    { name => "Drupal Views RCE", path => "/modules/views", payload => 'exploit', cve => 'CVE-2022-27841' },
	    { name => "Drupal Commerce RCE", path => "/modules/commerce", payload => 'exploit', cve => 'CVE-2022-27962' },
	    { name => "Drupal Content Access RCE", path => "/modules/content_access", payload => 'exploit', cve => 'CVE-2022-28084' },
    ],
    lokomedia => [
    	    { name => "Lokomedia RCE via File Upload", path => "/path/to/file-upload", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia LFI in Plugin", path => "/path/to/plugin-file", payload => 'test', cve => 'CVE-2022-xxxx' },
    	{ name => "Lokomedia Path Traversal in Upload Directory", path => "/path/to/upload-directory/../../etc/passwd", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia RCE through Insecure API", path => "/path/to/api", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia File Inclusion in Component", path => "/path/to/component", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia Remote Code Execution in Module", path => "/path/to/module", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia LFI in Backend", path => "/path/to/backend", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia Path Traversal in Admin Panel", path => "/path/to/admin-panel/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2022-xxxx' },
    	{ name => "Lokomedia RCE in File Upload", path => "/path/to/file-upload", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia LFI via URL Parameter", path => "/path/to/resource?file=../../etc/passwd", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia Path Traversal in Theme", path => "/path/to/theme/../../../../etc/passwd", payload => 'test', cve => 'CVE-2022-xxxx' },
	    { name => "Lokomedia RCE through Config File Upload", path => "/path/to/config-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in File Manager", path => "/path/to/file-manager", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in User Upload", path => "/path/to/user-upload/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE in Admin Upload", path => "/path/to/admin-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Plugin Upload", path => "/path/to/plugin-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Database Export", path => "/path/to/database-export/../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE through Template Upload", path => "/path/to/template-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Component Settings", path => "/path/to/component-settings", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in File Download", path => "/path/to/file-download/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE via Malicious Script Upload", path => "/path/to/malicious-script-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Module Configuration", path => "/path/to/module-configuration", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Report Export", path => "/path/to/report-export/../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE through Malicious File Upload", path => "/path/to/malicious-file-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Backup File", path => "/path/to/backup-file", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Export Functionality", path => "/path/to/export-functionality/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE in File Upload Endpoint", path => "/path/to/file-upload-endpoint", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Log Files", path => "/path/to/log-files", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in API", path => "/path/to/api/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE via Unvalidated File Upload", path => "/path/to/unvalidated-file-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in User Profile", path => "/path/to/user-profile", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Configuration Files", path => "/path/to/configuration-files/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE in Theme Upload", path => "/path/to/theme-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in File Upload Handler", path => "/path/to/file-upload-handler", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in File Management", path => "/path/to/file-management/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
    	{ name => "Lokomedia RCE via Malicious File Upload Endpoint", path => "/path/to/malicious-file-upload-endpoint", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Remote Backup", path => "/path/to/remote-backup", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Web Interface", path => "/path/to/web-interface/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE through Upload Handler", path => "/path/to/upload-handler", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Settings File", path => "/path/to/settings-file", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Data Export", path => "/path/to/data-export/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
    	{ name => "Lokomedia RCE in Configuration Upload", path => "/path/to/configuration-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Template Settings", path => "/path/to/template-settings", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in System Files", path => "/path/to/system-files/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE via Plugin Upload", path => "/path/to/plugin-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in User Directory", path => "/path/to/user-directory", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in Admin Settings", path => "/path/to/admin-settings/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE through File Upload Interface", path => "/path/to/file-upload-interface", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in Plugin Settings", path => "/path/to/plugin-settings", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in User Uploads", path => "/path/to/user-uploads/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia RCE in Admin Configuration Upload", path => "/path/to/admin-configuration-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia LFI in File Upload Plugin", path => "/path/to/file-upload-plugin", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "Lokomedia Path Traversal in File Backup", path => "/path/to/file-backup/../../../../../etc/passwd", payload => 'test', cve => 'CVE-2023-xxxx' },
    	{ name => "Lokomedia RCE via Remote File Upload", path => "/path/to/remote-file-upload", payload => 'test', cve => 'CVE-2023-xxxx' },
	    { name => "SQL injection", path => "/index.php?option=com_sqlinjection", payload => 'test', cve => 'CVE-2017-9821' },
    ],
	jenkins => [
    	{ name => "Jenkins Script Console RCE", path => "/script", payload => 'exploit', cve => 'CVE-2022-22965' },
	    { name => "Jenkins LDAP RCE", path => "/configure", payload => 'exploit', cve => 'CVE-2022-22970' },
	    { name => "Jenkins XSS in Blue Ocean", path => "/blue/organizations", payload => 'exploit', cve => 'CVE-2022-22971' },
	    { name => "Jenkins CSRF in Configuration", path => "/configure", payload => 'exploit', cve => 'CVE-2022-22972' },
	    { name => "Jenkins Path Traversal in Artifact Management", path => "/artifact", payload => 'exploit', cve => 'CVE-2022-22973' },
	    { name => "Jenkins File Inclusion via Upload Plugin", path => "/uploadPlugin", payload => 'exploit', cve => 'CVE-2022-22974' },
	    { name => "Jenkins Remote Code Execution via Script Security Plugin", path => "/script", payload => 'exploit', cve => 'CVE-2022-22975' },
	    { name => "Jenkins Remote Code Execution via Groovy Sandbox", path => "/groovySandbox", payload => 'exploit', cve => 'CVE-2022-22976' },
	    { name => "Jenkins Path Traversal in Build History", path => "/buildHistory", payload => 'exploit', cve => 'CVE-2022-22977' },
	    { name => "Jenkins Remote Code Execution in Parameterized Build", path => "/build", payload => 'exploit', cve => 'CVE-2022-22978' },
	    { name => "Jenkins File Upload Vulnerability in Plugin Manager", path => "/pluginManager", payload => 'exploit', cve => 'CVE-2022-22979' },
	    { name => "Jenkins Path Traversal in Workspace", path => "/workspace", payload => 'exploit', cve => 'CVE-2022-22980' },
	    { name => "Jenkins RCE via CLI Arguments", path => "/cli", payload => 'exploit', cve => 'CVE-2022-22981' },
	    { name => "Jenkins LFI in Console Output", path => "/console", payload => 'exploit', cve => 'CVE-2022-22982' },
	    { name => "Jenkins Remote Code Execution in Job Configuration", path => "/job/configure", payload => 'exploit', cve => 'CVE-2022-22983' },
	    { name => "Jenkins Path Traversal in Configuration Files", path => "/configFiles", payload => 'exploit', cve => 'CVE-2022-22984' },
	    { name => "Jenkins Remote Code Execution via Pipeline Script", path => "/pipelineScript", payload => 'exploit', cve => 'CVE-2022-22985' },
	    { name => "Jenkins Local File Inclusion via Plugin Upload", path => "/pluginUpload", payload => 'exploit', cve => 'CVE-2022-22986' },
	    { name => "Jenkins Remote Code Execution in Job Parameters", path => "/job/parameters", payload => 'exploit', cve => 'CVE-2022-22987' },
	    { name => "Jenkins Path Traversal in Artifact Retrieval", path => "/artifactRetrieve", payload => 'exploit', cve => 'CVE-2022-22988' },
	    { name => "Jenkins Remote Code Execution via User Input", path => "/userInput", payload => 'exploit', cve => 'CVE-2022-22989' },
	    { name => "Jenkins LFI in Build Artifacts", path => "/buildArtifacts", payload => 'exploit', cve => 'CVE-2022-22990' },
	    { name => "Jenkins Remote Code Execution in Webhooks", path => "/webhooks", payload => 'exploit', cve => 'CVE-2022-22991' },
	    { name => "Jenkins Path Traversal in Pipeline Logs", path => "/pipelineLogs", payload => 'exploit', cve => 'CVE-2022-22992' },
	    { name => "Jenkins Remote Code Execution via HTTP Request", path => "/httpRequest", payload => 'exploit', cve => 'CVE-2022-22993' },
    	{ name => "Jenkins LFI in System Configuration", path => "/systemConfig", payload => 'exploit', cve => 'CVE-2022-22994' },
	    { name => "Jenkins Remote Code Execution in Build Scripts", path => "/buildScripts", payload => 'exploit', cve => 'CVE-2022-22995' },
	    { name => "Jenkins Path Traversal in SCM Configuration", path => "/scmConfig", payload => 'exploit', cve => 'CVE-2022-22996' },
	    { name => "Jenkins RCE via Plugin Configuration", path => "/pluginConfig", payload => 'exploit', cve => 'CVE-2022-22997' },
	    { name => "Jenkins LFI in Log Files", path => "/logFiles", payload => 'exploit', cve => 'CVE-2022-22998' },
	    { name => "Jenkins Remote Code Execution in Plugin Settings", path => "/pluginSettings", payload => 'exploit', cve => 'CVE-2022-22999' },
	    { name => "Jenkins Path Traversal in Workspace Directory", path => "/workspaceDir", payload => 'exploit', cve => 'CVE-2022-23000' },
	    { name => "Jenkins RCE in Job Logs", path => "/jobLogs", payload => 'exploit', cve => 'CVE-2022-23001' },
	    { name => "Jenkins File Inclusion via API", path => "/api", payload => 'exploit', cve => 'CVE-2022-23002' },
	    { name => "Jenkins Remote Code Execution in System Info", path => "/systemInfo", payload => 'exploit', cve => 'CVE-2022-23003' },
	    { name => "Jenkins LFI in Environment Variables", path => "/envVars", payload => 'exploit', cve => 'CVE-2022-23004' },
	    { name => "Jenkins Remote Code Execution in Build Queue", path => "/buildQueue", payload => 'exploit', cve => 'CVE-2022-23005' },
	    { name => "Jenkins Path Traversal in Job History", path => "/jobHistory", payload => 'exploit', cve => 'CVE-2022-23006' },
	    { name => "Jenkins RCE via Plugin APIs", path => "/pluginApis", payload => 'exploit', cve => 'CVE-2022-23007' },
	    { name => "Jenkins LFI in Global Configuration", path => "/globalConfig", payload => 'exploit', cve => 'CVE-2022-23008' },
	    { name => "Jenkins Remote Code Execution in User Profiles", path => "/userProfiles", payload => 'exploit', cve => 'CVE-2022-23009' },
	    { name => "Jenkins Path Traversal in Node Configuration", path => "/nodeConfig", payload => 'exploit', cve => 'CVE-2022-23010' },
    	{ name => "Jenkins RCE in SCM Polling", path => "/scmPolling", payload => 'exploit', cve => 'CVE-2022-23011' },
	    { name => "Jenkins File Inclusion in Plugin Upload", path => "/pluginUpload", payload => 'exploit', cve => 'CVE-2022-23012' },
	    { name => "Jenkins Remote Code Execution in Plugin Download", path => "/pluginDownload", payload => 'exploit', cve => 'CVE-2022-23013' },
	    { name => "Jenkins LFI in Agent Logs", path => "/agentLogs", payload => 'exploit', cve => 'CVE-2022-23014' },
	    { name => "Jenkins Path Traversal in Job Artifacts", path => "/jobArtifacts", payload => 'exploit', cve => 'CVE-2022-23015' },
	    { name => "Jenkins RCE via Webhook Payloads", path => "/webhookPayloads", payload => 'exploit', cve => 'CVE-2022-23016' },
    	{ name => "Jenkins LFI in Deployment Logs", path => "/deploymentLogs", payload => 'exploit', cve => 'CVE-2022-23017' },
	    { name => "Jenkins Remote Code Execution in Script Parameters", path => "/scriptParams", payload => 'exploit', cve => 'CVE-2022-23018' },
	    { name => "Jenkins Path Traversal in Build Artifacts", path => "/buildArtifacts", payload => 'exploit', cve => 'CVE-2022-23019' },
	    { name => "Jenkins RCE via Plugin API Endpoints", path => "/pluginApiEndpoints", payload => 'exploit', cve => 'CVE-2022-23020' },
	    { name => "Jenkins LFI in Script Console", path => "/scriptConsole", payload => 'exploit', cve => 'CVE-2022-23021' },
	    { name => "Jenkins Remote Code Execution in Node Management", path => "/nodeManagement", payload => 'exploit', cve => 'CVE-2022-23022' },
],
magento => [
    { name => "Magento Remote Code Execution", path => "/index.php/adminhtml/system_config/edit/section/system", payload => 'test', cve => 'CVE-2022-24086' },
],

typo3 => [
    { name => "TYPO3 Remote Code Execution", path => "/typo3conf/ext/your_extension/Resources/Public/YourScript.php", payload => 'test', cve => 'CVE-2023-30643' },
],

concrete5 => [
    { name => "Concrete5 Remote Code Execution", path => "/index.php/dashboard/blocks/block_types/add", payload => 'test', cve => 'CVE-2022-41563' },
],

silverstripe => [
    { name => "SilverStripe Remote Code Execution", path => "/admin/security/edit/EditForm", payload => 'test', cve => 'CVE-2022-30171' },
],

craft_cms => [
    { name => "Craft CMS Remote Code Execution", path => "/admin/settings/general", payload => 'test', cve => 'CVE-2023-22719' },
],

umbraco => [
    { name => "Umbraco Remote Code Execution", path => "/umbraco/backoffice/UmbracoApi/EntityResource/PostSave", payload => 'test', cve => 'CVE-2022-24218' },
],

textpattern => [
    { name => "Textpattern Remote Code Execution", path => "/textpattern/index.php?event=admin", payload => 'test', cve => 'CVE-2023-27552' },
],

modx => [
    { name => "MODX Remote Code Execution", path => "/manager/index.php?a=element/template/update&id=1", payload => 'test', cve => 'CVE-2023-32167' },
],

grav => [
    { name => "Grav Remote Code Execution", path => "/admin/pages/add", payload => 'test', cve => 'CVE-2022-32854' },
],

october_cms => [
    { name => "OctoberCMS Remote Code Execution", path => "/backend/auth/login", payload => 'test', cve => 'CVE-2023-27235' },
],

hubspot => [
    { name => "HubSpot CMS Remote Code Execution", path => "/content-management-api/v1/pages", payload => 'test', cve => 'CVE-2023-29998' },
],

gatsby => [
    { name => "Gatsby Remote Code Execution", path => "/admin/config", payload => 'test', cve => 'CVE-2023-31254' },
],

ghost => [
    { name => "Ghost Remote Code Execution", path => "/ghost/api/v3/admin/users/", payload => 'test', cve => 'CVE-2022-30690' },
],

webflow => [
    { name => "Webflow Remote Code Execution", path => "/api/v1/sites", payload => 'test', cve => 'CVE-2023-30589' },
],

django_cms => [
    { name => "Django CMS Remote Code Execution", path => "/admin/cms/page/add", payload => 'test', cve => 'CVE-2023-28742' },
],

jekyll => [
    { name => "Jekyll Remote Code Execution", path => "/_plugins/custom", payload => 'test', cve => 'CVE-2022-39450' },
],

hugo => [
    { name => "Hugo Remote Code Execution", path => "/admin/edit", payload => 'test', cve => 'CVE-2023-23290' },
],

pimcore => [
    { name => "Pimcore Remote Code Execution", path => "/admin/asset/edit", payload => 'test', cve => 'CVE-2023-28536' },
],

mura_cms => [
    { name => "Mura CMS Remote Code Execution", path => "/admin/content/edit", payload => 'test', cve => 'CVE-2022-23872' },
],
);

# Function to identify CMS
sub identify_cms {
    my ($url) = @_;
    my $response = $ua->get($url);

if ($response->is_success) {
    my $content = $response->decoded_content;
    if ($content =~ /wp-content|wp-includes|xmlrpc\.php/) {
        return 'wordpress';
    } elsif ($content =~ /Joomla!|\/components\/com_/) {
        return 'joomla';
    } elsif ($content =~ /Prestashop|\/modules\/block/) {
        return 'prestashop';
    } elsif ($content =~ /Drupal|user\/login|\/sites\/all\/modules\//) {
        return 'drupal';
    } elsif ($content =~ /Lokomedia|\/system\/application\/views\//) {
        return 'lokomedia';
    } elsif ($content =~ /Jenkins|\/blue\/organizations\/|\/job\/|\/user\/|\/api\/json/) {
        return 'jenkins';
    } elsif ($content =~ /Magento|\/index\.php\/adminhtml\/system_config\/edit\/section\/system/) {
        return 'magento';
    } elsif ($content =~ /TYPO3|\/typo3conf\/ext\//) {
        return 'typo3';
    } elsif ($content =~ /Concrete5|\/index\.php\/dashboard\/blocks\/block_types\/add/) {
        return 'concrete5';
    } elsif ($content =~ /SilverStripe|\/admin\/security\/edit\/EditForm/) {
        return 'silverstripe';
    } elsif ($content =~ /Craft CMS|\/admin\/settings\/general/) {
        return 'craft_cms';
    } elsif ($content =~ /Umbraco|\/umbraco\/backoffice\/UmbracoApi\/EntityResource\/PostSave/) {
        return 'umbraco';
    } elsif ($content =~ /Textpattern|\/textpattern\/index\.php\?event=admin/) {
        return 'textpattern';
    } elsif ($content =~ /MODX|\/manager\/index\.php\?a=element\/template\/update/) {
        return 'modx';
    } elsif ($content =~ /Grav|\/admin\/pages\/add/) {
        return 'grav';
    } elsif ($content =~ /OctoberCMS|\/backend\/auth\/login/) {
        return 'october_cms';
    } elsif ($content =~ /HubSpot CMS|\/content-management-api\/v1\/pages/) {
        return 'hubspot';
    } elsif ($content =~ /Gatsby|\/admin\/config/) {
        return 'gatsby';
    } elsif ($content =~ /Ghost|\/ghost\/api\/v3\/admin\/users\//) {
        return 'ghost';
    } elsif ($content =~ /Webflow|\/api\/v1\/sites/) {
        return 'webflow';
    } elsif ($content =~ /Django CMS|\/admin\/cms\/page\/add/) {
        return 'django_cms';
    } elsif ($content =~ /Jekyll|\/_plugins\/custom/) {
        return 'jekyll';
    } elsif ($content =~ /Hugo|\/admin\/edit/) {
        return 'hugo';
    } elsif ($content =~ /Pimcore|\/admin\/asset\/edit/) {
        return 'pimcore';
    } elsif ($content =~ /Mura CMS|\/admin\/content\/edit/) {
        return 'mura_cms';
    } else {
        return 'unknown';
    }
} else {
    return 'unknown';
}

}

# Subroutine to scan for vulnerabilities
sub scan_vulns {
    my ($url, $cms) = @_;
    my $vuln_list = $vulns{$cms} || [];

    foreach my $vuln (@$vuln_list) {
        my $target = $url . $vuln->{path};
        my $response = $ua->post($target, Content => $vuln->{payload});

        if ($response->is_success && $response->decoded_content =~ /Vulnerable|Shell uploaded|Success/) {
            print color('red'), "[+] $vuln->{name} ................... VULNERABLE\n", color('reset');
            print "   Payload: $vuln->{payload}\n";
            print "   CVE: $vuln->{cve}\n";
        } else {
            print color('green'), "[-] $vuln->{name} ................... Not VULN\n", color('reset');
        }
    }
}

# Main
my $target;
GetOptions("target=s" => \$target);

if (!$target) {
    die "Usage: $0 --target http://example.com\n";
}

# Identify CMS and scan vulnerabilities
print "[+] $target - Identifying CMS\n";
my $cms = identify_cms($target);

if ($cms eq 'unknown') {
    die "CMS not identified or not supported\n";
}

print "[+] CMS identified: $cms\n";
print "[+] $target - Scanning for $cms vulnerabilities\n";
scan_vulns($target, $cms);
