#include "CBIInstrument.h"

using namespace llvm;

namespace instrument {

const auto PASS_NAME = "CBIInstrument";
const auto PASS_DESC = "Instrumentation for CBI";
const auto CBI_BRANCH_FUNCTION_NAME = "__cbi_branch__";
const auto CBI_RETURN_FUNCTION_NAME = "__cbi_return__";

/**
 * @brief Instrument a BranchInst with calls to __cbi_branch__
 *
 * @param M Module containing Branch
 * @param Branch A conditional Branch Instruction
 * @param Line Line number of Branch
 * @param Col Coulmn number of Branch
 */
void instrumentBranch(Module *M, BranchInst *Branch, int Line, int Col);

/**
 * @brief Instrument the return value of CallInst using calls to __cbi_return__
 *
 * @param M Module containing Call
 * @param Call A Call instruction that returns an Int32.
 * @param Line Line number of the Call
 * @param Col Column number of the Call
 */
void instrumentReturn(Module *M, CallInst *Call, int Line, int Col);

bool CBIInstrument::runOnFunction(Function &F) {
  auto FunctionName = F.getName().str();
  outs() << "Running " << PASS_DESC << " on function " << FunctionName << "\n";

  LLVMContext &Context = F.getContext();
  Module *M = F.getParent();

  Type *VoidType = Type::getVoidTy(Context);
  Type *Int32Type = Type::getInt32Ty(Context);
  Type *BoolType = Type::getInt1Ty(Context);

  M->getOrInsertFunction(CBI_BRANCH_FUNCTION_NAME, VoidType, Int32Type,
                         Int32Type, BoolType);

  M->getOrInsertFunction(CBI_RETURN_FUNCTION_NAME, VoidType, Int32Type,
                         Int32Type, Int32Type);

  for (inst_iterator Iter = inst_begin(F), E = inst_end(F); Iter != E; ++Iter) {
    Instruction &Inst = (*Iter);
    llvm::DebugLoc DebugLoc = Inst.getDebugLoc();
    if (!DebugLoc) {
      // Skip Instruction if it doesn't have debug information.
      continue;
    }

    int Line = DebugLoc.getLine();
    int Col = DebugLoc.getCol();

    /**
     * TODO: Add code to check the type of instruction
     * and call appropriate instrumentation function.
     *
     * If Inst is a Branch Instruction then
     *   use instrumentBranch
     * Else if it is a Call returning an int then
     *   use instrumentReturn
     * @param Branch
     */
    if(BranchInst *Branch = dyn_cast<BranchInst>(&Inst)){

      instrumentBranch(M, Branch, Line, Col);
    }

    else if(CallInst *Call = dyn_cast<CallInst>(&Inst)){
      instrumentReturn(M, Call, Line, Col);
    }
  }
  return true;
}

/**
 * Implement instrumentation for the branch scheme of CBI. (Lab 9)
 */
void instrumentBranch(Module *M, BranchInst *Branch, int Line, int Col) {
  auto &Context = M->getContext();
  auto Int32Type = Type::getInt32Ty(Context);

  /**
   * TODO: Add code to instrument the Branch Instruction.
   */
  auto LineVal = ConstantInt::get(Int32Type, Line);
  auto ColVal = ConstantInt::get(Int32Type, Col);

  if(Branch->isConditional()){
      Value* CondVal = Branch->getCondition();
      std::vector<Value*> Args = {LineVal, ColVal, CondVal};
      auto *BranchFunction = M->getFunction(CBI_BRANCH_FUNCTION_NAME);
      CallInst::Create(BranchFunction, Args, "", Branch);
  }
}

/**
 * Implement instrumentation for the return scheme of CBI. (Lab 9)
 */
void instrumentReturn(Module *M, CallInst *Call, int Line, int Col) {
  auto &Context = M->getContext();
  auto Int32Type = Type::getInt32Ty(Context);

  /**
   * TODO: Add code to instrument the Call Instruction.
   *
   * Note: CallInst::Create(.) follows Insert Before semantics.
   */
  auto LineVal = ConstantInt::get(Int32Type, Line);
  auto ColVal = ConstantInt::get(Int32Type, Col);
  int  ret = Call->getNumOperands();
  auto retVal = ConstantInt::get(Int32Type, ret);

  std::vector<Value *> Args = {LineVal, ColVal, retVal};
  auto *CallFunction = M->getFunction(CBI_RETURN_FUNCTION_NAME);
  CallInst::Create(CallFunction, Args, "", Call);
}

char CBIInstrument::ID = 1;
static RegisterPass<CBIInstrument> X(PASS_NAME, PASS_DESC, false, false);

} // namespace instrument
