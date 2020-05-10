public with sharing class AuraExceptionHandler {
    private AuraHandledException auraException;

    private AuraExceptionHandler(){}

    public static AuraExceptionHandlerBuilder builder() {
        return new AuraExceptionHandlerBuilder();
    }

    public AuraHandledException getAuraException() {
        return this.auraException;
    }

    public class AuraExceptionHandlerBuilder {

        private AuraExceptionHandler exceptionHandler;
        private Exception regularException;
        private String message;

        private AuraExceptionHandlerBuilder(){
            this.exceptionHandler = new AuraExceptionHandler();
        }

        public AuraExceptionHandler build() {
            setSpecifiedOrDefaultMessage();
            this.exceptionHandler.auraException = new AuraHandledException(this.message);
            this.exceptionHandler.auraException.setMessage(this.message);
            setCauseException();
            return this.exceptionHandler;
        }

        public AuraExceptionHandlerBuilder withException(Exception regularException) {
            this.regularException = regularException;
            return this;
        }

        private void setCauseException() {
            this.exceptionHandler.auraException.initCause(this.regularException);
        }

        private void setSpecifiedOrDefaultMessage() {
            if(this.message == null) {
                if(this.regularException instanceOf DmlException) {
                    this.message = getDMLMessages();
                } else {
                    this.message = this.regularException.getMessage();
                }
            }
        }

        private String getDMLMessages() {
            DmlException dmlEx = ((DmlException) this.regularException);
            String result = '';
            for(Integer i = 0; i < dmlEx.getNumDml(); i++) {
                result += dmlEx.getDmlMessage(i) + '\n';
            }
            return result;
        }
    }
}
