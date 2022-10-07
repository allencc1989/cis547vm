#include "Instrument.h"
#include "Utils.h"

using namespace llvm;

namespace instrument {

const auto PASS_NAME = "StaticAnalysisPass";
const auto PASS_DESC = "Static Analysis Pass";

bool Instrument::runOnFunction(Function &F) {
  auto FunctionName = F.getName().str();
  outs() << "Running " << PASS_DESC << " on function " << FunctionName << "\n";

  outs() << "Locating Instructions\n";
  for (inst_iterator Iter = inst_begin(F), E = inst_end(F); Iter != E; ++Iter) {
    Instruction &Inst = (*Iter);
    llvm::DebugLoc DebugLoc = Inst.getDebugLoc();
    if (!DebugLoc) {
      // Skip Instruction if it doesn't have debug information.
      continue;
    }

    int Line = DebugLoc.getLine();
    int Col = DebugLoc.getCol();
    outs() << Line << ", " << Col << "\n";

    /**
     * TODO: Add code to check if the instruction is a BinaryOperator and if so,
     * print the information about its location and operands as specified in the
     * Lab document.
     */
    if(Inst.isBinaryOp()){
      auto *binary = dyn_cast<BinaryOperator>(&Inst);
      Value* op1 = binary->getOperand(0);
      Value* op2 = binary->getOperand(1);
      std::string operand1 = variable(op1);
      std::string operand2 = variable(op2);
      Instruction::BinaryOps Opcode = binary->getOpcode();
      const char symbol = getBinOpSymbol(Opcode);
      std::string name = getBinOpName(symbol);
      outs()<< name << "on Line" << Line <<", Column"<<Col<<"with first operand"<< operand1 <<"and second operand"<< operand2<<"\n";
    }
  }
  return false;
}

char Instrument::ID = 1;
static RegisterPass<Instrument> X(PASS_NAME, PASS_NAME, false, false);

} // namespace instrument
