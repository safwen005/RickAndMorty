import UIKit

class ControlleSearchView {
  func prepareSearchField(_ textField: UITextField) {
    textField.setDefaultLeftPadding()
    textField.setBorderWidth(CGfloatConstants.searchBorderWidth)
    textField.setBorderColor(UIColorConstants.defaultColor)
    textField.setDefaultPlaceHolder(StringConstants.defaultSearchPlaceholder)
    textField.setCornerRadius(CGfloatConstants.characterCornerRadius)
  }
  
  func prepareViewsDefaultShape(nameButton: UIButton, statusButton: UIButton, speciesButton: UIButton) {
    nameButton.setCornerRadius(CGfloatConstants.characterCornerRadius)
    nameButton.setBackgroundColor(UIColorConstants.softBlue)
    statusButton.setCornerRadius(CGfloatConstants.characterCornerRadius)
    speciesButton.setCornerRadius(CGfloatConstants.characterCornerRadius)
  }
  
  func filterCharacters(searchText: String?, nameOrSpecies: NameOrSpecies, status: CharacterStatus) -> [CharacterFilterOption] {
    var filters = [CharacterFilterOption]()
    if let newSearchText = searchText {
      if !newSearchText.isEmpty {
        filters.append((nameOrSpecies == .name) ? .name(newSearchText) : .species(newSearchText))
      }
    }
    filters.append(.status(status))
    return filters
  }

  func showError(errorStackView: UIStackView, dataContainer: UIView) {
    dataContainer.hide()
    errorStackView.show()
  }
  
  func setErrorDescription(errorType: ResponseError?, errorDescriptionLabel: UILabel) {
    guard let responseType = errorType else { return }
    if responseType == .noInternetConnection {
      errorDescriptionLabel.text = NetworkStringDataConstants.noInternetErrorDescription
      return
    }
    errorDescriptionLabel.text = NetworkStringDataConstants.errorOccuredDescription
  }
}
