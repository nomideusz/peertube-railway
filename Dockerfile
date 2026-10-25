FROM chocobozzz/peertube:v7.3.0-bookworm

COPY railway-entrypoint.sh /railway-entrypoint.sh
RUN chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
CMD ["node", "dist/server"]
