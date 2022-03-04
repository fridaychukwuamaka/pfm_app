'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.CampaignInterface = exports.CampaignCreateResponse = exports.Campaign = undefined;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

var _lodash = require('lodash');

var _ = _interopRequireWildcard(_lodash);

var _base = require('../base');

var _common = require('../utils/common.js');

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var action = '10dlc/Campaign/';
var idField = 'brandID';
var actionKey = Symbol('api action');
var klassKey = Symbol('constructor');
var idKey = Symbol('id filed');
var clientKey = Symbol('make api call');

/**
 * Represents a Campaign
 * @constructor
 * @param {function} client - make api call
 * @param {object} [data] - data of call
 */

var Campaign = exports.Campaign = function (_PlivoResource) {
    _inherits(Campaign, _PlivoResource);

    function Campaign(client) {
        var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        _classCallCheck(this, Campaign);

        var _this = _possibleConstructorReturn(this, (Campaign.__proto__ || Object.getPrototypeOf(Campaign)).call(this, action, Campaign, idField, client));

        _this[actionKey] = action;
        _this[clientKey] = client;
        if (idField in data) {
            _this.id = data[idField];
        };

        (0, _common.extend)(_this, data);
        return _this;
    }

    return Campaign;
}(_base.PlivoResource);

var CampaignCreateResponse = exports.CampaignCreateResponse = function CampaignCreateResponse(params) {
    _classCallCheck(this, CampaignCreateResponse);

    params = params || {};
    this.apiId = params.apiId;
    this.campaign = params.campaign;
};

/**
 * Represents a Campaign Interface
 * @constructor
 * @param {function} client - make api call
 * @param {object} [data] - data of call
 */


var CampaignInterface = exports.CampaignInterface = function (_PlivoResource2) {
    _inherits(CampaignInterface, _PlivoResource2);

    function CampaignInterface(client) {
        var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        _classCallCheck(this, CampaignInterface);

        var _this2 = _possibleConstructorReturn(this, (CampaignInterface.__proto__ || Object.getPrototypeOf(CampaignInterface)).call(this, action, Campaign, idField, client));

        (0, _common.extend)(_this2, data);
        _this2[clientKey] = client;
        _this2[actionKey] = action;
        _this2[klassKey] = Campaign;
        _this2[idKey] = idField;
        return _this2;
    }

    /**
     * get Campaign by given id
     * @method
     * @param {string} campaignID - id of Campaign
     * @promise {object} return {@link Campaign} object
     * @fail {Error} return Error
     */


    _createClass(CampaignInterface, [{
        key: 'get',
        value: function get(campaignID) {
            var params = {};
            return _get(CampaignInterface.prototype.__proto__ || Object.getPrototypeOf(CampaignInterface.prototype), 'customexecuteAction', this).call(this, action + campaignID + '/', 'GET', params);
        }

        /**
         * Get All Campaign Detail
         * @method
         * @param {object} params - params brand and usecase to get all campaign details.
         * @promise {object[]} returns list of campaign Object
         * @fail {Error} returns Error
         */

    }, {
        key: 'list',
        value: function list(params) {
            return _get(CampaignInterface.prototype.__proto__ || Object.getPrototypeOf(CampaignInterface.prototype), 'customexecuteAction', this).call(this, action, 'GET', params);
        }

        /**
         * create Campaign
         * @method
         * @param {string} brand_id 
         * @param {string} campaign_alias 
         * @param {string} vertical 
         * @param {string} usecase 
         * @param {list} sub_usecases 
         * @param {string} description  
         * @param {boolean} embedded_link 
         * @param {boolean} embedded_phone 
         * @param {boolean} age_gated 
         * @param {boolean} direct_lending 
         * @param {boolean} subscriber_optin 
         * @param {boolean} subscriber_optout 
         * @param {boolean} subscriber_help 
         * @param {string} sample1 
         * @param {string} sample2 
         * @promise {object} return {@link PlivoGenericResponse} object
         * @fail {Error} return Error
         */

    }, {
        key: 'create',
        value: function create(brand_id, campaign_alias, vertical, usecase, sub_usecases, description, embedded_link, embedded_phone, age_gated, direct_lending, subscriber_optin, subscriber_optout, subscriber_help, sample1, sample2) {
            var params = {};
            params.brand_id = brand_id;
            params.campaign_alias = campaign_alias;
            params.vertical = vertical;
            params.usecase = usecase;
            params.sub_usecases = sub_usecases;
            params.description = description;
            params.embedded_link = embedded_link;
            params.embedded_phone = embedded_phone;
            params.age_gated = age_gated;
            params.direct_lending = direct_lending;
            params.subscriber_optin = subscriber_optin;
            params.subscriber_optout = subscriber_optout;
            params.subscriber_help = subscriber_help;
            params.sample1 = sample1;
            params.sample2 = sample2;
            var client = this[clientKey];
            return new Promise(function (resolve, reject) {
                client('POST', action, params).then(function (response) {
                    resolve(new CampaignCreateResponse(response.body, idField));
                }).catch(function (error) {
                    reject(error);
                });
            });
        }
    }]);

    return CampaignInterface;
}(_base.PlivoResource);