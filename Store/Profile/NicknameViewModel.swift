//
//  NicknameViewModel.swift
//  Store
//
//  Created by J Oh on 7/9/24.
//

import Foundation

final class NicknameViewModel {
    
    var inputNickname: Observable<String?> = Observable(nil)
    
    var outputValidationText = Observable("")
    var outputValid = Observable(false)
    
    init(_ nickname: String?) {
        print("ViewModel init")
        inputNickname.value = nickname
        inputNickname.bind { _ in
            self.validation()
        }
    }
    
    private func validation() {
        guard let nickname = inputNickname.value else { return }
        
        do {
            try isValidateInput(nickname: nickname)
            outputValidationText.value = "사용할 수 있는 닉네임이에요"
            outputValid.value = true
            return
        } catch NicknameValidationError.lengthError {
            outputValidationText.value = "2글자 이상 10글자 미만 입력해주세요"
        } catch NicknameValidationError.symbolError {
            outputValidationText.value = "@, #, $, %는 포함할 수 없습니다"
        } catch NicknameValidationError.numError {
            outputValidationText.value = "숫자는 포함할 수 없습니다"
        } catch {
            fatalError()
        }
        
        outputValid.value = false
        
    }
    
    @discardableResult
    func isValidateInput(nickname: String) throws -> Bool {
        guard nickname.count >= 2 && nickname.count < 10 else { throw NicknameValidationError.lengthError }
        guard nickname.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%")) == nil else { throw NicknameValidationError.symbolError }
        guard nickname.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) == nil else { throw NicknameValidationError.numError }
        return true
    }
    
}
