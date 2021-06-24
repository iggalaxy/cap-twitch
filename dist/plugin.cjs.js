'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const Twitch = core.registerPlugin('Twitch', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.TwitchWeb()),
});

class TwitchWeb extends core.WebPlugin {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async openStream(_options) {
        throw new Error('No web implementation for TwitchWeb: openStream');
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    TwitchWeb: TwitchWeb
});

exports.Twitch = Twitch;
//# sourceMappingURL=plugin.cjs.js.map
