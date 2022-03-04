'use strict';

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.BrandInterface = exports.BrandCreationResponse = exports.Brand = undefined;

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

var action = '10dlc/Brand/';
var idField = 'brand_id';
var clientKey = Symbol();
var idKey = Symbol('id filed');

/**
 * Represents a Brand
 * @constructor
 * @param {function} client - make api call
 * @param {object} [data] - data of call
 */

var Brand = exports.Brand = function (_PlivoResource) {
    _inherits(Brand, _PlivoResource);

    function Brand(client) {
        var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        _classCallCheck(this, Brand);

        var _this = _possibleConstructorReturn(this, (Brand.__proto__ || Object.getPrototypeOf(Brand)).call(this, action, Brand, idField, client));

        _this[actionKey] = action;
        _this[clientKey] = client;

        (0, _common.extend)(_this, data);
        return _this;
    }

    return Brand;
}(_base.PlivoResource);

var BrandCreationResponse = exports.BrandCreationResponse = function BrandCreationResponse(params) {
    _classCallCheck(this, BrandCreationResponse);

    params = params || {};
    this.apiId = params.apiId;
    this.brand = params.brand;
};

/**
 * Represents a Brand Interface
 * @constructor
 * @param {function} client - make api call
 * @param {object} [data] - data of call
 */


var BrandInterface = exports.BrandInterface = function (_PlivoResource2) {
    _inherits(BrandInterface, _PlivoResource2);

    function BrandInterface(client) {
        var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

        _classCallCheck(this, BrandInterface);

        var _this2 = _possibleConstructorReturn(this, (BrandInterface.__proto__ || Object.getPrototypeOf(BrandInterface)).call(this, action, Brand, idField, client));

        (0, _common.extend)(_this2, data);
        _this2[clientKey] = client;
        return _this2;
    }

    /**
    * get Brand by given id
    * @method
    * @param {string} brandID - id of brand
    * @promise {object} return {@link Brand} object
    * @fail {Error} return Error
    */


    _createClass(BrandInterface, [{
        key: 'get',
        value: function get(brandId) {
            var params = {};
            return _get(BrandInterface.prototype.__proto__ || Object.getPrototypeOf(BrandInterface.prototype), 'customexecuteAction', this).call(this, action + brandId + '/', 'GET', params);
        }
        /**
         * Get All Brand Detail
         * @method
         * @param {object} params - params type and status to get all brand details.
         * @promise {object[]} returns list of Brand Object
         * @fail {Error} returns Error
         */

    }, {
        key: 'list',
        value: function list(params) {
            return _get(BrandInterface.prototype.__proto__ || Object.getPrototypeOf(BrandInterface.prototype), 'customexecuteAction', this).call(this, action, 'GET', params);
        }

        /**
         * Brand Registration
         * @method
         * @param {object} params 
         * @param {string} city
         * @param {string} company_name
         * @param {string} country
         * @param {string} ein
         * @param {string} ein_issuing_country
         * @param {string} email
         * @param {string} entity_type
         * @param {string} postal_code
         * @param {string} registration_status
         * @param {string} state
         * @param {string} stock_exchange
         * @param {string} stock_symbol
         * @param {string} street
         * @param {string} vertical
         * @param {string} [params.website] -
         * @param {string} [params.secondary_vetting]
         * @param {string} [params.first_name]
         * @param {string} [params.last_name]
         * @param {string} [params.alt_business_id_type]
         * @param {string} [params.alt_business_id]
         * @promise {object} return {@link PlivoGenericResponse} object
         * @fail {Error} return Error
         */

    }, {
        key: 'create',
        value: function create(city, company_name, country, ein, ein_issuing_country, email, entity_type, phone, postal_code, registration_status, state, stock_exchange, stock_symbol, street, vertical) {
            var params = arguments.length > 15 && arguments[15] !== undefined ? arguments[15] : {};

            params.city = city;
            params.company_name = company_name;
            params.country = country;
            params.ein = ein;
            params.ein_issuing_country = ein_issuing_country;
            params.email = email;
            params.entity_type = entity_type;
            params.phone = phone;
            params.postal_code = postal_code;
            params.registration_status = registration_status;
            params.state = state;
            params.stock_exchange = stock_exchange;
            params.stock_symbol = stock_symbol;
            params.street = street;
            params.vertical = vertical;
            var client = this[clientKey];
            var idField = this[idKey];
            return new Promise(function (resolve, reject) {
                client('POST', action, params).then(function (response) {
                    resolve(new BrandCreationResponse(response.body, idField));
                }).catch(function (error) {
                    reject(error);
                });
            });
        }
    }]);

    return BrandInterface;
}(_base.PlivoResource);