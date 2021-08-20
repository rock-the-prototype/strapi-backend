module.exports = ({ env }) => ({
  defaultConnection: 'default',
  connections: {
    default: {
      connector: 'bookshelf',
      settings: {
        client: 'postgres',
        host: env('DATABASE_HOST', 'postgres13master'),
        port: env.int('DATABASE_PORT', 5432),
        database: env('DATABASE_NAME', 'strapi'),
        username: env('DATABASE_USERNAME', 'strapidb'),
        password: env('DATABASE_PASSWORD', '4C#e%3mMR#6a7cdVYFqHb'),
        ssl: false
      },
      options: {},
    },
  },
});
