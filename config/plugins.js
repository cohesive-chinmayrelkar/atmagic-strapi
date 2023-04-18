// ~/strapi-aws-s3/backend/config/plugins.js

module.exports = ({ env }) => ({
    upload: {
        config: {
            provider: 'aws-s3',
            providerOptions: {
                region: "us-west-1",
                params: {
                    Bucket: "cohesivelive-componentsstack-u-provisioningbucket-1syxiqgtsobo9/apps-by-cohesive-0fyz/strapi-app",
                },
            },
        },
    },
});
