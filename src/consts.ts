// Place any global data in this file.
// You can import this data from anywhere in your site by using the `import` keyword.

import * as config from "astro:env/client";

/**
 * The title of the website.
 */
export const kSiteTitle: string = config.SITE_TITLE || "My Blog";

/**
 * The title of the website.
 */
export const kSiteLogo: string = kSiteTitle;
/**
 * The description of the website.
 */
export const kSiteDescription: string = config.SITE_DESCRIPTION || "My blog.";
/**
 * The baidu verification code, used for SEO.
 */
export const kBaiduVeriCode: string | undefined =
  config.BAIDU_VERIFICATION_CODE;

/**
 * The URL base of the website.
 * - For a GitHub page `https://username.github.io/repo`, the URL base is `/repo/`.
 * - For a netlify page, the URL base is `/`.
 */
export const kUrlBase = (config.URL_BASE || "").replace(/\/$/, "");
