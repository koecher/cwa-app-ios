// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: internal/v2/app_config_ios.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

/// This file is auto-generated, DO NOT make any changes here

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct SAP_Internal_V2_ApplicationConfigurationIOS {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var minVersion: SAP_Internal_V2_SemanticVersion {
    get {return _storage._minVersion ?? SAP_Internal_V2_SemanticVersion()}
    set {_uniqueStorage()._minVersion = newValue}
  }
  /// Returns true if `minVersion` has been explicitly set.
  var hasMinVersion: Bool {return _storage._minVersion != nil}
  /// Clears the value of `minVersion`. Subsequent reads from it will return its default value.
  mutating func clearMinVersion() {_uniqueStorage()._minVersion = nil}

  var latestVersion: SAP_Internal_V2_SemanticVersion {
    get {return _storage._latestVersion ?? SAP_Internal_V2_SemanticVersion()}
    set {_uniqueStorage()._latestVersion = newValue}
  }
  /// Returns true if `latestVersion` has been explicitly set.
  var hasLatestVersion: Bool {return _storage._latestVersion != nil}
  /// Clears the value of `latestVersion`. Subsequent reads from it will return its default value.
  mutating func clearLatestVersion() {_uniqueStorage()._latestVersion = nil}

  var appFeatures: SAP_Internal_V2_AppFeatures {
    get {return _storage._appFeatures ?? SAP_Internal_V2_AppFeatures()}
    set {_uniqueStorage()._appFeatures = newValue}
  }
  /// Returns true if `appFeatures` has been explicitly set.
  var hasAppFeatures: Bool {return _storage._appFeatures != nil}
  /// Clears the value of `appFeatures`. Subsequent reads from it will return its default value.
  mutating func clearAppFeatures() {_uniqueStorage()._appFeatures = nil}

  var supportedCountries: [String] {
    get {return _storage._supportedCountries}
    set {_uniqueStorage()._supportedCountries = newValue}
  }

  var keyDownloadParameters: SAP_Internal_V2_KeyDownloadParametersIOS {
    get {return _storage._keyDownloadParameters ?? SAP_Internal_V2_KeyDownloadParametersIOS()}
    set {_uniqueStorage()._keyDownloadParameters = newValue}
  }
  /// Returns true if `keyDownloadParameters` has been explicitly set.
  var hasKeyDownloadParameters: Bool {return _storage._keyDownloadParameters != nil}
  /// Clears the value of `keyDownloadParameters`. Subsequent reads from it will return its default value.
  mutating func clearKeyDownloadParameters() {_uniqueStorage()._keyDownloadParameters = nil}

  var exposureDetectionParameters: SAP_Internal_V2_ExposureDetectionParametersIOS {
    get {return _storage._exposureDetectionParameters ?? SAP_Internal_V2_ExposureDetectionParametersIOS()}
    set {_uniqueStorage()._exposureDetectionParameters = newValue}
  }
  /// Returns true if `exposureDetectionParameters` has been explicitly set.
  var hasExposureDetectionParameters: Bool {return _storage._exposureDetectionParameters != nil}
  /// Clears the value of `exposureDetectionParameters`. Subsequent reads from it will return its default value.
  mutating func clearExposureDetectionParameters() {_uniqueStorage()._exposureDetectionParameters = nil}

  var riskCalculationParameters: SAP_Internal_V2_RiskCalculationParameters {
    get {return _storage._riskCalculationParameters ?? SAP_Internal_V2_RiskCalculationParameters()}
    set {_uniqueStorage()._riskCalculationParameters = newValue}
  }
  /// Returns true if `riskCalculationParameters` has been explicitly set.
  var hasRiskCalculationParameters: Bool {return _storage._riskCalculationParameters != nil}
  /// Clears the value of `riskCalculationParameters`. Subsequent reads from it will return its default value.
  mutating func clearRiskCalculationParameters() {_uniqueStorage()._riskCalculationParameters = nil}

  var exposureConfiguration: SAP_Internal_V2_ExposureConfiguration {
    get {return _storage._exposureConfiguration ?? SAP_Internal_V2_ExposureConfiguration()}
    set {_uniqueStorage()._exposureConfiguration = newValue}
  }
  /// Returns true if `exposureConfiguration` has been explicitly set.
  var hasExposureConfiguration: Bool {return _storage._exposureConfiguration != nil}
  /// Clears the value of `exposureConfiguration`. Subsequent reads from it will return its default value.
  mutating func clearExposureConfiguration() {_uniqueStorage()._exposureConfiguration = nil}

  var eventDrivenUserSurveyParameters: SAP_Internal_V2_PPDDEventDrivenUserSurveyParametersIOS {
    get {return _storage._eventDrivenUserSurveyParameters ?? SAP_Internal_V2_PPDDEventDrivenUserSurveyParametersIOS()}
    set {_uniqueStorage()._eventDrivenUserSurveyParameters = newValue}
  }
  /// Returns true if `eventDrivenUserSurveyParameters` has been explicitly set.
  var hasEventDrivenUserSurveyParameters: Bool {return _storage._eventDrivenUserSurveyParameters != nil}
  /// Clears the value of `eventDrivenUserSurveyParameters`. Subsequent reads from it will return its default value.
  mutating func clearEventDrivenUserSurveyParameters() {_uniqueStorage()._eventDrivenUserSurveyParameters = nil}

  var privacyPreservingAnalyticsParameters: SAP_Internal_V2_PPDDPrivacyPreservingAnalyticsParametersIOS {
    get {return _storage._privacyPreservingAnalyticsParameters ?? SAP_Internal_V2_PPDDPrivacyPreservingAnalyticsParametersIOS()}
    set {_uniqueStorage()._privacyPreservingAnalyticsParameters = newValue}
  }
  /// Returns true if `privacyPreservingAnalyticsParameters` has been explicitly set.
  var hasPrivacyPreservingAnalyticsParameters: Bool {return _storage._privacyPreservingAnalyticsParameters != nil}
  /// Clears the value of `privacyPreservingAnalyticsParameters`. Subsequent reads from it will return its default value.
  mutating func clearPrivacyPreservingAnalyticsParameters() {_uniqueStorage()._privacyPreservingAnalyticsParameters = nil}

  var errorLogSharingParameters: SAP_Internal_V2_PPDDErrorLogSharingParametersIOS {
    get {return _storage._errorLogSharingParameters ?? SAP_Internal_V2_PPDDErrorLogSharingParametersIOS()}
    set {_uniqueStorage()._errorLogSharingParameters = newValue}
  }
  /// Returns true if `errorLogSharingParameters` has been explicitly set.
  var hasErrorLogSharingParameters: Bool {return _storage._errorLogSharingParameters != nil}
  /// Clears the value of `errorLogSharingParameters`. Subsequent reads from it will return its default value.
  mutating func clearErrorLogSharingParameters() {_uniqueStorage()._errorLogSharingParameters = nil}

  var presenceTracingParameters: SAP_Internal_V2_PresenceTracingParameters {
    get {return _storage._presenceTracingParameters ?? SAP_Internal_V2_PresenceTracingParameters()}
    set {_uniqueStorage()._presenceTracingParameters = newValue}
  }
  /// Returns true if `presenceTracingParameters` has been explicitly set.
  var hasPresenceTracingParameters: Bool {return _storage._presenceTracingParameters != nil}
  /// Clears the value of `presenceTracingParameters`. Subsequent reads from it will return its default value.
  mutating func clearPresenceTracingParameters() {_uniqueStorage()._presenceTracingParameters = nil}

  var coronaTestParameters: SAP_Internal_V2_CoronaTestParameters {
    get {return _storage._coronaTestParameters ?? SAP_Internal_V2_CoronaTestParameters()}
    set {_uniqueStorage()._coronaTestParameters = newValue}
  }
  /// Returns true if `coronaTestParameters` has been explicitly set.
  var hasCoronaTestParameters: Bool {return _storage._coronaTestParameters != nil}
  /// Clears the value of `coronaTestParameters`. Subsequent reads from it will return its default value.
  mutating func clearCoronaTestParameters() {_uniqueStorage()._coronaTestParameters = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

struct SAP_Internal_V2_ExposureConfiguration {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var infectiousnessForDaysSinceOnsetOfSymptoms: Dictionary<Int32,Int32> = [:]

  var reportTypeNoneMap: Int32 = 0

  var attenuationDurationThresholds: [Int32] = []

  var immediateDurationWeight: Double = 0

  var mediumDurationWeight: Double = 0

  var nearDurationWeight: Double = 0

  var otherDurationWeight: Double = 0

  var daysSinceLastExposureThreshold: Int32 = 0

  var infectiousnessStandardWeight: Double = 0

  var infectiousnessHighWeight: Double = 0

  var reportTypeConfirmedTestWeight: Double = 0

  var reportTypeConfirmedClinicalDiagnosisWeight: Double = 0

  var reportTypeSelfReportedWeight: Double = 0

  var reportTypeRecursiveWeight: Double = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "SAP.internal.v2"

extension SAP_Internal_V2_ApplicationConfigurationIOS: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ApplicationConfigurationIOS"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "minVersion"),
    2: .same(proto: "latestVersion"),
    3: .same(proto: "appFeatures"),
    4: .same(proto: "supportedCountries"),
    5: .same(proto: "keyDownloadParameters"),
    6: .same(proto: "exposureDetectionParameters"),
    7: .same(proto: "riskCalculationParameters"),
    8: .same(proto: "exposureConfiguration"),
    9: .same(proto: "eventDrivenUserSurveyParameters"),
    10: .same(proto: "privacyPreservingAnalyticsParameters"),
    11: .same(proto: "errorLogSharingParameters"),
    12: .same(proto: "presenceTracingParameters"),
    13: .same(proto: "coronaTestParameters"),
  ]

  fileprivate class _StorageClass {
    var _minVersion: SAP_Internal_V2_SemanticVersion? = nil
    var _latestVersion: SAP_Internal_V2_SemanticVersion? = nil
    var _appFeatures: SAP_Internal_V2_AppFeatures? = nil
    var _supportedCountries: [String] = []
    var _keyDownloadParameters: SAP_Internal_V2_KeyDownloadParametersIOS? = nil
    var _exposureDetectionParameters: SAP_Internal_V2_ExposureDetectionParametersIOS? = nil
    var _riskCalculationParameters: SAP_Internal_V2_RiskCalculationParameters? = nil
    var _exposureConfiguration: SAP_Internal_V2_ExposureConfiguration? = nil
    var _eventDrivenUserSurveyParameters: SAP_Internal_V2_PPDDEventDrivenUserSurveyParametersIOS? = nil
    var _privacyPreservingAnalyticsParameters: SAP_Internal_V2_PPDDPrivacyPreservingAnalyticsParametersIOS? = nil
    var _errorLogSharingParameters: SAP_Internal_V2_PPDDErrorLogSharingParametersIOS? = nil
    var _presenceTracingParameters: SAP_Internal_V2_PresenceTracingParameters? = nil
    var _coronaTestParameters: SAP_Internal_V2_CoronaTestParameters? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _minVersion = source._minVersion
      _latestVersion = source._latestVersion
      _appFeatures = source._appFeatures
      _supportedCountries = source._supportedCountries
      _keyDownloadParameters = source._keyDownloadParameters
      _exposureDetectionParameters = source._exposureDetectionParameters
      _riskCalculationParameters = source._riskCalculationParameters
      _exposureConfiguration = source._exposureConfiguration
      _eventDrivenUserSurveyParameters = source._eventDrivenUserSurveyParameters
      _privacyPreservingAnalyticsParameters = source._privacyPreservingAnalyticsParameters
      _errorLogSharingParameters = source._errorLogSharingParameters
      _presenceTracingParameters = source._presenceTracingParameters
      _coronaTestParameters = source._coronaTestParameters
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularMessageField(value: &_storage._minVersion) }()
        case 2: try { try decoder.decodeSingularMessageField(value: &_storage._latestVersion) }()
        case 3: try { try decoder.decodeSingularMessageField(value: &_storage._appFeatures) }()
        case 4: try { try decoder.decodeRepeatedStringField(value: &_storage._supportedCountries) }()
        case 5: try { try decoder.decodeSingularMessageField(value: &_storage._keyDownloadParameters) }()
        case 6: try { try decoder.decodeSingularMessageField(value: &_storage._exposureDetectionParameters) }()
        case 7: try { try decoder.decodeSingularMessageField(value: &_storage._riskCalculationParameters) }()
        case 8: try { try decoder.decodeSingularMessageField(value: &_storage._exposureConfiguration) }()
        case 9: try { try decoder.decodeSingularMessageField(value: &_storage._eventDrivenUserSurveyParameters) }()
        case 10: try { try decoder.decodeSingularMessageField(value: &_storage._privacyPreservingAnalyticsParameters) }()
        case 11: try { try decoder.decodeSingularMessageField(value: &_storage._errorLogSharingParameters) }()
        case 12: try { try decoder.decodeSingularMessageField(value: &_storage._presenceTracingParameters) }()
        case 13: try { try decoder.decodeSingularMessageField(value: &_storage._coronaTestParameters) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._minVersion {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._latestVersion {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._appFeatures {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if !_storage._supportedCountries.isEmpty {
        try visitor.visitRepeatedStringField(value: _storage._supportedCountries, fieldNumber: 4)
      }
      if let v = _storage._keyDownloadParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
      }
      if let v = _storage._exposureDetectionParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      }
      if let v = _storage._riskCalculationParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
      if let v = _storage._exposureConfiguration {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
      }
      if let v = _storage._eventDrivenUserSurveyParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 9)
      }
      if let v = _storage._privacyPreservingAnalyticsParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 10)
      }
      if let v = _storage._errorLogSharingParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 11)
      }
      if let v = _storage._presenceTracingParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 12)
      }
      if let v = _storage._coronaTestParameters {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 13)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SAP_Internal_V2_ApplicationConfigurationIOS, rhs: SAP_Internal_V2_ApplicationConfigurationIOS) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._minVersion != rhs_storage._minVersion {return false}
        if _storage._latestVersion != rhs_storage._latestVersion {return false}
        if _storage._appFeatures != rhs_storage._appFeatures {return false}
        if _storage._supportedCountries != rhs_storage._supportedCountries {return false}
        if _storage._keyDownloadParameters != rhs_storage._keyDownloadParameters {return false}
        if _storage._exposureDetectionParameters != rhs_storage._exposureDetectionParameters {return false}
        if _storage._riskCalculationParameters != rhs_storage._riskCalculationParameters {return false}
        if _storage._exposureConfiguration != rhs_storage._exposureConfiguration {return false}
        if _storage._eventDrivenUserSurveyParameters != rhs_storage._eventDrivenUserSurveyParameters {return false}
        if _storage._privacyPreservingAnalyticsParameters != rhs_storage._privacyPreservingAnalyticsParameters {return false}
        if _storage._errorLogSharingParameters != rhs_storage._errorLogSharingParameters {return false}
        if _storage._presenceTracingParameters != rhs_storage._presenceTracingParameters {return false}
        if _storage._coronaTestParameters != rhs_storage._coronaTestParameters {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension SAP_Internal_V2_ExposureConfiguration: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".ExposureConfiguration"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "infectiousnessForDaysSinceOnsetOfSymptoms"),
    2: .same(proto: "reportTypeNoneMap"),
    3: .same(proto: "attenuationDurationThresholds"),
    4: .same(proto: "immediateDurationWeight"),
    5: .same(proto: "mediumDurationWeight"),
    6: .same(proto: "nearDurationWeight"),
    7: .same(proto: "otherDurationWeight"),
    8: .same(proto: "daysSinceLastExposureThreshold"),
    9: .same(proto: "infectiousnessStandardWeight"),
    10: .same(proto: "infectiousnessHighWeight"),
    11: .same(proto: "reportTypeConfirmedTestWeight"),
    12: .same(proto: "reportTypeConfirmedClinicalDiagnosisWeight"),
    13: .same(proto: "reportTypeSelfReportedWeight"),
    14: .same(proto: "reportTypeRecursiveWeight"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufInt32,SwiftProtobuf.ProtobufInt32>.self, value: &self.infectiousnessForDaysSinceOnsetOfSymptoms) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.reportTypeNoneMap) }()
      case 3: try { try decoder.decodeRepeatedInt32Field(value: &self.attenuationDurationThresholds) }()
      case 4: try { try decoder.decodeSingularDoubleField(value: &self.immediateDurationWeight) }()
      case 5: try { try decoder.decodeSingularDoubleField(value: &self.mediumDurationWeight) }()
      case 6: try { try decoder.decodeSingularDoubleField(value: &self.nearDurationWeight) }()
      case 7: try { try decoder.decodeSingularDoubleField(value: &self.otherDurationWeight) }()
      case 8: try { try decoder.decodeSingularInt32Field(value: &self.daysSinceLastExposureThreshold) }()
      case 9: try { try decoder.decodeSingularDoubleField(value: &self.infectiousnessStandardWeight) }()
      case 10: try { try decoder.decodeSingularDoubleField(value: &self.infectiousnessHighWeight) }()
      case 11: try { try decoder.decodeSingularDoubleField(value: &self.reportTypeConfirmedTestWeight) }()
      case 12: try { try decoder.decodeSingularDoubleField(value: &self.reportTypeConfirmedClinicalDiagnosisWeight) }()
      case 13: try { try decoder.decodeSingularDoubleField(value: &self.reportTypeSelfReportedWeight) }()
      case 14: try { try decoder.decodeSingularDoubleField(value: &self.reportTypeRecursiveWeight) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.infectiousnessForDaysSinceOnsetOfSymptoms.isEmpty {
      try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMap<SwiftProtobuf.ProtobufInt32,SwiftProtobuf.ProtobufInt32>.self, value: self.infectiousnessForDaysSinceOnsetOfSymptoms, fieldNumber: 1)
    }
    if self.reportTypeNoneMap != 0 {
      try visitor.visitSingularInt32Field(value: self.reportTypeNoneMap, fieldNumber: 2)
    }
    if !self.attenuationDurationThresholds.isEmpty {
      try visitor.visitPackedInt32Field(value: self.attenuationDurationThresholds, fieldNumber: 3)
    }
    if self.immediateDurationWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.immediateDurationWeight, fieldNumber: 4)
    }
    if self.mediumDurationWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.mediumDurationWeight, fieldNumber: 5)
    }
    if self.nearDurationWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.nearDurationWeight, fieldNumber: 6)
    }
    if self.otherDurationWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.otherDurationWeight, fieldNumber: 7)
    }
    if self.daysSinceLastExposureThreshold != 0 {
      try visitor.visitSingularInt32Field(value: self.daysSinceLastExposureThreshold, fieldNumber: 8)
    }
    if self.infectiousnessStandardWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.infectiousnessStandardWeight, fieldNumber: 9)
    }
    if self.infectiousnessHighWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.infectiousnessHighWeight, fieldNumber: 10)
    }
    if self.reportTypeConfirmedTestWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.reportTypeConfirmedTestWeight, fieldNumber: 11)
    }
    if self.reportTypeConfirmedClinicalDiagnosisWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.reportTypeConfirmedClinicalDiagnosisWeight, fieldNumber: 12)
    }
    if self.reportTypeSelfReportedWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.reportTypeSelfReportedWeight, fieldNumber: 13)
    }
    if self.reportTypeRecursiveWeight != 0 {
      try visitor.visitSingularDoubleField(value: self.reportTypeRecursiveWeight, fieldNumber: 14)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: SAP_Internal_V2_ExposureConfiguration, rhs: SAP_Internal_V2_ExposureConfiguration) -> Bool {
    if lhs.infectiousnessForDaysSinceOnsetOfSymptoms != rhs.infectiousnessForDaysSinceOnsetOfSymptoms {return false}
    if lhs.reportTypeNoneMap != rhs.reportTypeNoneMap {return false}
    if lhs.attenuationDurationThresholds != rhs.attenuationDurationThresholds {return false}
    if lhs.immediateDurationWeight != rhs.immediateDurationWeight {return false}
    if lhs.mediumDurationWeight != rhs.mediumDurationWeight {return false}
    if lhs.nearDurationWeight != rhs.nearDurationWeight {return false}
    if lhs.otherDurationWeight != rhs.otherDurationWeight {return false}
    if lhs.daysSinceLastExposureThreshold != rhs.daysSinceLastExposureThreshold {return false}
    if lhs.infectiousnessStandardWeight != rhs.infectiousnessStandardWeight {return false}
    if lhs.infectiousnessHighWeight != rhs.infectiousnessHighWeight {return false}
    if lhs.reportTypeConfirmedTestWeight != rhs.reportTypeConfirmedTestWeight {return false}
    if lhs.reportTypeConfirmedClinicalDiagnosisWeight != rhs.reportTypeConfirmedClinicalDiagnosisWeight {return false}
    if lhs.reportTypeSelfReportedWeight != rhs.reportTypeSelfReportedWeight {return false}
    if lhs.reportTypeRecursiveWeight != rhs.reportTypeRecursiveWeight {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
