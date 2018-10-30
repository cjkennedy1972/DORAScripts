<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */
define('WP_HOME', 'http://' . $_SERVER['SERVER_NAME']);
define('WP_SITEURL', WP_HOME . '/');

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', 'root' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '[,o:}RI6+B(C6)X<_Bc;e*]!>WUCizJ>+<qR;7i6JCb5}%b<NT*_^n7rBt}Ef1!)' );
define( 'SECURE_AUTH_KEY',  '7%m(O;}@{ME LFn>EOP,n<sW`Cq5m;xGtVuUV*@fzeZ^:,g:iR?{CN_kqe,WqqI}' );
define( 'LOGGED_IN_KEY',    'z`fsBdf8<UM&?OFjt1j@elk]c05ZhaT%i)~)o3*QOOq$~)YbJpHc;*NzU?_l`j@(' );
define( 'NONCE_KEY',        '&R{v#*+oCxeBq0?XhT<N-GTCXuy[nw~c+HJm/#Ld.Fnz!iT!HXU.0xpo^DhnP_am' );
define( 'AUTH_SALT',        '?!HS0<_!VpzCY/fW39Y@0WA+o[~}CGw,A#s+94<>%/BEAYHD%Sjr32slEsjAGX{.' );
define( 'SECURE_AUTH_SALT', 'v&M>j%!R@%e&uY0$k)?b~epBd;vMK.ERLe/A^x7svrN(<)FL/Wd^3}U|E>y%ljvO' );
define( 'LOGGED_IN_SALT',   'q<)SRIoX lYgEnqGUt6LClLJS3^Hk4KkX~$6Nx!U^pS7d3iGdj8ZE]k?=%~xe7w~' );
define( 'NONCE_SALT',       '!{f]X;V>sY(}.?k_c+v0}E%8S_XQ4`GwqrVhgcfMa/>Bd >.yto)wt Jivj$Pxzb' );

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );