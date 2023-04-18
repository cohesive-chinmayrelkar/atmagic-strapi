module.exports = [
  'strapi::errors',
  // 'strapi::security',
  {
    name: 'strapi::security',
    config: {
      contentSecurityPolicy: {
        useDefaults: true,
        directives: {
          'connect-src': ["'self'", 'https:'],
          'img-src': ["'self'", 'data:', 'blob:', 'cohesivelive-componentsstack-u-provisioningbucket-1syxiqgtsobo9.s3.us-west-1.amazonaws.com'],
          'media-src': ["'self'", 'data:', 'blob:', 'cohesivelive-componentsstack-u-provisioningbucket-1syxiqgtsobo9.s3.us-west-1.amazonaws.com'],
          upgradeInsecureRequests: null,
        },
      },
    },
  },
  'strapi::cors',
  'strapi::poweredBy',
  'strapi::logger',
  'strapi::query',
  'strapi::body',
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
];
