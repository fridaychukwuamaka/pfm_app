'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.LOAInterface = exports.LOA = exports.ListLOAResponse = exports.CreateLOAResponse = exports.LOAResponse = undefined;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _base = require('../base');

var _common = require('../utils/common.js');

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var clientKey = Symbol();
var action = 'HostedMessagingNumber/LOA/';
var idField = 'loaID';

var LOAResponse = exports.LOAResponse = function LOAResponse(params) {
  _classCallCheck(this, LOAResponse);

  params = params || {};
  this.apiId = params.apiId;
  this.alias = params.alias;
  this.file = params.file;
  this.loaId = params.loaId;
  this.linkedNumbers = params.linkedNumbers;
  this.createdAt = params.createdAt;
  this.resourceUri = params.resourceUri;
};

var CreateLOAResponse = exports.CreateLOAResponse = function CreateLOAResponse(params) {
  _classCallCheck(this, CreateLOAResponse);

  params = params || {};
  this.loaId = params.loaId;
  this.apiId = params.apiId;
  this.alias = params.alias;
  this.file = params.file;
  this.linkedNumbers = params.linkedNumbers;
  this.createdAt = params.createdAt;
  this.resourceUri = params.resourceUri;
  this.message = params.message;
};

var ListLOAResponse = exports.ListLOAResponse = function ListLOAResponse(params) {
  _classCallCheck(this, ListLOAResponse);

  params = params || {};
  this.apiId = params.apiId;
  this.meta = params.metaResponse;
  this.objects = params.objects;
};

var LOA = exports.LOA = function (_PlivoResource) {
  _inherits(LOA, _PlivoResource);

  function LOA(client) {
    var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck(this, LOA);

    var _this = _possibleConstructorReturn(this, (LOA.__proto__ || Object.getPrototypeOf(LOA)).call(this, action, LOA, idField, client));

    if (idField in data) {
      _this.id = data[idField];
    }
    _this[clientKey] = client;
    (0, _common.extend)(_this, data);
    return _this;
  }

  /**
   * get LOA by given id
   * @method
   * @param {string} id - id of the LOA
   * @promise {object} return {@link LOA} object
   * @fail {Error} return Error
   */


  _createClass(LOA, [{
    key: 'get',
    value: function get(id) {
      var _this2 = this;

      var client = this[clientKey];
      return new Promise(function (resolve, reject) {
        if (action !== '' && !id) {
          reject(new Error(_this2[idKey] + ' must be set'));
        }
        client('GET', action + (id ? id + '/' : '')).then(function (response) {
          var object = new LOAResponse(response.body, client);
          Object.keys(object).forEach(function (key) {
            return object[key] === undefined && delete object[key];
          });
          resolve(object);
        }).catch(function (error) {
          reject(error);
        });
      });
    }

    /**
     * list all LOA
     * @method
     * @param {object} params - params containing options to list LOA by.
     * @param {string} [params.alias] - Alias
     */

  }, {
    key: 'list',
    value: function list() {
      var params = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

      var client = this[clientKey];
      return new Promise(function (resolve, reject) {
        client('GET', action, params).then(function (response) {
          resolve(new ListLOAResponse(response.body, idField));
        }).catch(function (error) {
          reject(error);
        });
      });
    }

    /**
     * Create an LOA
     * @method
     * @param {object} params
     * @param {string} [params.alias] - Alias
     * @param {string} [params.file] - File to be uploaded
     * @fail {Error} return Error
     */

  }, {
    key: 'create',
    value: function create() {
      var params = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

      var client = this[clientKey];
      return new Promise(function (resolve, reject) {
        params.multipart = true;
        client('POST', action, params).then(function (response) {
          var object = new CreateLOAResponse(response.body, idField);
          Object.keys(object).forEach(function (key) {
            return object[key] === undefined && delete object[key];
          });
          resolve(object);
        }).catch(function (error) {
          reject(error);
        });
      });
    }

    /**
     * deletes an LOA
     * @method
     * @param {string} id - id to delete
     * @promise {boolean} return true if success
     * @fail {Error} return Error
     */

  }, {
    key: 'delete',
    value: function _delete(id) {
      var _this3 = this;

      var client = this[clientKey];

      return new Promise(function (resolve, reject) {
        if (action !== '' && !id) {
          reject(new Error(_this3[idKey] + ' must be set'));
        }
        client('DELETE', action + id + '/').then(function () {
          resolve(true);
        }).catch(function (error) {
          reject(error);
        });
      });
    }
  }]);

  return LOA;
}(_base.PlivoResource);

/**
 * Represents a LOA interface
 * @constructor
 * @param {function} client - make api call
 * @param {object} [data] - data of call
 */


var LOAInterface = exports.LOAInterface = function (_PlivoResourceInterfa) {
  _inherits(LOAInterface, _PlivoResourceInterfa);

  function LOAInterface(client) {
    var data = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : {};

    _classCallCheck(this, LOAInterface);

    var _this4 = _possibleConstructorReturn(this, (LOAInterface.__proto__ || Object.getPrototypeOf(LOAInterface)).call(this, action, LOA, idField, client));

    (0, _common.extend)(_this4, data);
    _this4[clientKey] = client;
    return _this4;
  }

  /**
   * get LOA by given id
   * @method
   * @param {string} id - id of the loa
   * @promise {object} return {@link LOA} object
   * @fail {Error} return Error
   */


  _createClass(LOAInterface, [{
    key: 'get',
    value: function get(id) {
      var errors = (0, _common.validate)([{ field: 'id', value: id, validators: ['isRequired', 'isString'] }]);
      if (errors) {
        return errors;
      }
      return new LOA(this[clientKey], { id: idField }).get(id);
    }

    /**
     * list all LOA
     * @method
     * @param {object} params - params containing options to list LOA by.
     * @param {string} [params.alias] - Alias
     * @fail {Error} return Error
     */

  }, {
    key: 'list',
    value: function list() {
      var params = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

      var validations = [];
      if (params.hasOwnProperty("alias")) {
        validations.push({ field: 'alias', value: params.alias, validators: ['isString'] });
      }
      var errors = (0, _common.validate)(validations);
      if (errors) {
        return errors;
      }
      return new LOA(this[clientKey], { id: idField }).list(params);
    }

    /**
     * Create an LOA
     * @method
     * @param {object} params
     * @param {string} [params.alias] - Alias
     * @param {string} [params.file] - File to be uploaded
     * @fail {Error} return Error
     */

  }, {
    key: 'create',
    value: function create() {
      var params = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : {};

      var errors = (0, _common.validate)([{
        field: 'alias',
        value: params.alias,
        validators: ['isRequired', 'isString']
      }, { field: 'file', value: params.alias, validators: ['isRequired'] }]);

      if (errors) {
        return errors;
      }

      return new LOA(this[clientKey], { id: idField }).create(params);
    }

    /**
     * delete an LOA
     * @method
     * @param {string} id - id to delete
     * @promise {boolean} return true if success
     * @fail {Error} return Error
     */

  }, {
    key: 'delete',
    value: function _delete(id) {
      var errors = (0, _common.validate)([{
        field: 'id', value: id, validators: ['isRequired', "isString"]
      }]);

      if (errors) {
        return errors;
      }
      return new LOA(this[clientKey], { id: idField }).delete(id);
    }
  }]);

  return LOAInterface;
}(_base.PlivoResourceInterface);