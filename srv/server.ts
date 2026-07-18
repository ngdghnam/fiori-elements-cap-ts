import "reflect-metadata";
import cds from '@sap/cds';
import cov2ap from '@cap-js-community/odata-v2-adapter';

console.log("==> Loading custom server.ts");

cds.on('bootstrap', (app) => {
    console.log("==> Bootstrapping V2 Adapter");
    try {
        app.use(cov2ap());
        console.log("==> V2 Adapter bootstrapped successfully");
    } catch (e) {
        console.error("==> V2 Adapter failed", e);
    }
});
